from __future__ import annotations

import argparse
import hashlib
import re
import xml.etree.ElementTree as ET

from dataclasses import dataclass, field
from itertools import combinations
from pathlib import Path
from typing import Iterable

import pandas as pd


# ============================================================
# CONFIGURATION
# ============================================================

SUPPORTED_EXTENSIONS = {".rdl"}

SIMILARITY_WEIGHTS = {
    "column": 0.25,
    "query": 0.25,
    "expression": 0.15,
    "parameter": 0.10,
    "data_source": 0.10,
    "structure": 0.15,
}

THRESHOLDS = {
    "exact_duplicate": 99.99,
    "very_high": 90.00,
    "high": 75.00,
    "medium": 50.00,

    # Retirement Review:
    # Reports with very high similarity should be reviewed to determine
    # whether one report can be retired.
    "retirement_review": 90.00,

    # Direct Consolidation:
    # Reports with similar columns, queries, and structure may be merged.
    "direct_consolidation_overall": 85.00,
    "direct_consolidation_column": 80.00,
    "direct_consolidation_query": 75.00,
    "direct_consolidation_structure": 70.00,

    # Backend Optimization:
    # Similar queries may indicate reusable SQL, stored procedures,
    # semantic models, or datasets.
    "backend_optimization_query": 70.00,

    # Exact Feature Duplicate:
    # All extracted comparison features must match.
    "exact_feature_duplicate": 100.00,
}

OUTPUT_COLUMNS = [
    "Report 1",
    "Report 2",
    "Overall Similarity %",
    "Classification",
    "Retirement Review",
    "Direct Consolidation Eligible",
    "Backend Optimization Eligible",
    "Exact Feature Duplicate",
    "Column Similarity %",
    "Query Similarity %",
    "Expression Similarity %",
    "Parameter Similarity %",
    "Data Source Similarity %",
    "Structure Similarity %",
    "Report 1 Column Count",
    "Report 2 Column Count",
    "Common Column Count",
    "Common Columns",
    "Report 1 Only Columns",
    "Report 2 Only Columns",
    "Report 1 Dataset Count",
    "Report 2 Dataset Count",
    "Report 1 Query Count",
    "Report 2 Query Count",
    "Report 1 Parameter Count",
    "Report 2 Parameter Count",
    "Report 1 Structure",
    "Report 2 Structure",
    "Report 1 Path",
    "Report 2 Path",
]


# ============================================================
# DATA MODEL
# ============================================================

@dataclass
class RDLFeatures:
    report_name: str
    path: str

    columns: set[str] = field(default_factory=set)
    queries: set[str] = field(default_factory=set)
    expressions: set[str] = field(default_factory=set)
    parameters: set[str] = field(default_factory=set)
    data_sources: set[str] = field(default_factory=set)
    structure_items: set[str] = field(default_factory=set)

    dataset_names: set[str] = field(default_factory=set)
    query_count: int = 0

    normalized_xml_hash: str = ""
    parse_error: str = ""

    @property
    def dataset_count(self) -> int:
        return len(self.dataset_names)

    @property
    def parameter_count(self) -> int:
        return len(self.parameters)

    @property
    def structure_summary(self) -> str:
        if not self.structure_items:
            return ""

        return "; ".join(sorted(self.structure_items))


# ============================================================
# XML AND TEXT HELPERS
# ============================================================

def local_name(tag: str) -> str:
    """
    Removes the XML namespace from a tag.

    Example:
        {http://schemas.microsoft.com/sqlserver/reporting/2016/01/reportdefinition}DataSet
        becomes:
        DataSet
    """
    if "}" in tag:
        return tag.split("}", 1)[1]

    return tag


def normalize_identifier(value: str | None) -> str:
    """
    Normalizes names such as field names, dataset names, parameters,
    and data-source names.
    """
    if not value:
        return ""

    value = value.strip().casefold()
    value = re.sub(r"\s+", " ", value)

    return value


def normalize_expression(value: str | None) -> str:
    """
    Normalizes RDL expressions while preserving their logical content.
    """
    if not value:
        return ""

    value = value.strip().casefold()

    # Normalize line breaks and repeated whitespace.
    value = re.sub(r"\s+", " ", value)

    # Normalize spacing around common expression operators.
    value = re.sub(r"\s*([+\-*/=&<>(),])\s*", r"\1", value)

    return value


def normalize_query(value: str | None) -> str:
    """
    Performs practical SQL normalization for comparison.

    This is not a complete SQL parser. It removes comments, normalizes
    whitespace, casing, brackets, and common punctuation spacing.
    """
    if not value:
        return ""

    query = value.casefold()

    # Remove SQL block comments.
    query = re.sub(r"/\*.*?\*/", " ", query, flags=re.DOTALL)

    # Remove SQL single-line comments.
    query = re.sub(r"--[^\r\n]*", " ", query)

    # Remove square brackets around SQL identifiers.
    query = re.sub(r"\[([^\]]+)\]", r"\1", query)

    # Normalize whitespace.
    query = re.sub(r"\s+", " ", query).strip()

    # Normalize spacing around punctuation and operators.
    query = re.sub(r"\s*([(),=<>+\-*/])\s*", r"\1", query)

    # Remove trailing semicolon.
    query = query.rstrip(";").strip()

    return query


def get_element_text(element: ET.Element) -> str:
    """
    Retrieves all text contained within an element.
    """
    return "".join(element.itertext()).strip()


def find_elements(root: ET.Element, element_name: str) -> Iterable[ET.Element]:
    """
    Finds elements using the local tag name, regardless of XML namespace.
    """
    for element in root.iter():
        if local_name(element.tag) == element_name:
            yield element


def find_direct_child(
    parent: ET.Element,
    child_name: str,
) -> ET.Element | None:
    """
    Finds a direct child using the namespace-independent local name.
    """
    for child in list(parent):
        if local_name(child.tag) == child_name:
            return child

    return None


def child_text(parent: ET.Element, child_name: str) -> str:
    """
    Returns the text from a direct child.
    """
    child = find_direct_child(parent, child_name)

    if child is None:
        return ""

    return get_element_text(child)


def normalized_xml_hash(root: ET.Element) -> str:
    """
    Produces a deterministic hash after normalizing element names,
    attributes, and textual content.
    """

    parts: list[str] = []

    def walk(element: ET.Element) -> None:
        tag_name = local_name(element.tag).casefold()
        parts.append(f"<{tag_name}>")

        for key, value in sorted(element.attrib.items()):
            normalized_key = local_name(key).casefold()
            normalized_value = normalize_identifier(value)
            parts.append(f"@{normalized_key}={normalized_value}")

        if element.text and element.text.strip():
            text = normalize_expression(element.text)
            parts.append(text)

        for child in list(element):
            walk(child)

        parts.append(f"</{tag_name}>")

    walk(root)

    normalized_content = "|".join(parts)
    return hashlib.sha256(
        normalized_content.encode("utf-8")
    ).hexdigest()


# ============================================================
# FEATURE EXTRACTION
# ============================================================

def extract_columns(root: ET.Element) -> set[str]:
    """
    Extracts columns from:
      1. DataSet Fields
      2. Field references in expressions
    """

    columns: set[str] = set()

    # Extract declared dataset fields.
    for field_element in find_elements(root, "Field"):
        field_name = normalize_identifier(field_element.attrib.get("Name"))

        if field_name:
            columns.add(field_name)

        data_field = child_text(field_element, "DataField")
        data_field = normalize_identifier(data_field)

        if data_field:
            columns.add(data_field)

    # Extract Fields!ColumnName.Value references from expressions.
    field_reference_pattern = re.compile(
        r"fields!\s*([a-zA-Z0-9_ .\-]+?)\s*\.value",
        flags=re.IGNORECASE,
    )

    for element in root.iter():
        text = get_element_text(element)

        if not text:
            continue

        for match in field_reference_pattern.findall(text):
            field_name = normalize_identifier(match)

            if field_name:
                columns.add(field_name)

    return columns


def extract_queries(root: ET.Element) -> tuple[set[str], int]:
    """
    Extracts normalized CommandText elements.

    The set is used for similarity. The count represents the number
    of non-empty query definitions in the report.
    """

    queries: set[str] = set()
    query_count = 0

    for command_text in find_elements(root, "CommandText"):
        query = normalize_query(get_element_text(command_text))

        if query:
            query_count += 1
            queries.add(query)

    return queries, query_count


def extract_expressions(root: ET.Element) -> set[str]:
    """
    Extracts values that look like RDL expressions.

    Most RDL expressions begin with an equals sign.
    """

    expressions: set[str] = set()

    excluded_tags = {
        "CommandText",
        "ConnectString",
    }

    for element in root.iter():
        tag = local_name(element.tag)

        if tag in excluded_tags:
            continue

        text = get_element_text(element).strip()

        if text.startswith("="):
            normalized = normalize_expression(text)

            if normalized:
                expressions.add(normalized)

    return expressions


def extract_parameters(root: ET.Element) -> set[str]:
    """
    Extracts report parameter definitions and query parameter definitions.
    """

    parameters: set[str] = set()

    parameter_element_names = {
        "ReportParameter",
        "QueryParameter",
    }

    for element in root.iter():
        tag = local_name(element.tag)

        if tag not in parameter_element_names:
            continue

        parameter_name = normalize_identifier(element.attrib.get("Name"))

        if parameter_name:
            parameters.add(parameter_name)

    # Also capture Parameters!ParameterName.Value references.
    parameter_pattern = re.compile(
        r"parameters!\s*([a-zA-Z0-9_ .\-]+?)\s*\.value",
        flags=re.IGNORECASE,
    )

    for element in root.iter():
        text = get_element_text(element)

        for match in parameter_pattern.findall(text):
            parameter_name = normalize_identifier(match)

            if parameter_name:
                parameters.add(parameter_name)

    return parameters


def extract_data_sources(root: ET.Element) -> set[str]:
    """
    Extracts data-source names, references, provider names,
    and normalized connection strings.
    """

    data_sources: set[str] = set()

    for element in root.iter():
        tag = local_name(element.tag)

        if tag == "DataSource":
            name = normalize_identifier(element.attrib.get("Name"))

            if name:
                data_sources.add(f"name:{name}")

        elif tag == "DataSourceReference":
            reference = normalize_identifier(get_element_text(element))

            if reference:
                data_sources.add(f"reference:{reference}")

        elif tag == "DataProvider":
            provider = normalize_identifier(get_element_text(element))

            if provider:
                data_sources.add(f"provider:{provider}")

        elif tag == "ConnectString":
            connection_string = normalize_connection_string(
                get_element_text(element)
            )

            if connection_string:
                data_sources.add(f"connection:{connection_string}")

    return data_sources


def normalize_connection_string(connection_string: str) -> str:
    """
    Normalizes connection-string properties while masking passwords
    and other sensitive values.
    """
    if not connection_string:
        return ""

    sensitive_keys = {
        "password",
        "pwd",
        "access token",
        "accesstoken",
    }

    properties = []

    for part in connection_string.split(";"):
        part = part.strip()

        if not part:
            continue

        if "=" not in part:
            properties.append(normalize_identifier(part))
            continue

        key, value = part.split("=", 1)
        key = normalize_identifier(key)
        value = normalize_identifier(value)

        if key in sensitive_keys:
            value = "<masked>"

        properties.append(f"{key}={value}")

    return ";".join(sorted(properties))


def extract_dataset_names(root: ET.Element) -> set[str]:
    """
    Extracts dataset names.
    """

    dataset_names: set[str] = set()

    for dataset in find_elements(root, "DataSet"):
        name = normalize_identifier(dataset.attrib.get("Name"))

        if name:
            dataset_names.add(name)

    return dataset_names


def extract_structure(root: ET.Element) -> set[str]:
    """
    Creates structural features from report items and selected containers.

    Examples:
        tablix:salesmatrix
        chart:chart1
        rectangle:container1
        textbox:reporttitle
        tablix:rowgroups=2
        tablix:columngroups=3
    """

    structure_tags = {
        "Tablix",
        "Table",
        "Matrix",
        "Chart",
        "GaugePanel",
        "Map",
        "Subreport",
        "List",
        "Rectangle",
        "Textbox",
        "Image",
        "Line",
        "PageHeader",
        "PageFooter",
        "Body",
    }

    structure_items: set[str] = set()

    for element in root.iter():
        tag = local_name(element.tag)

        if tag not in structure_tags:
            continue

        normalized_tag = tag.casefold()
        item_name = normalize_identifier(element.attrib.get("Name"))

        if item_name:
            structure_items.add(f"{normalized_tag}:{item_name}")
        else:
            structure_items.add(normalized_tag)

        if tag == "Tablix":
            row_group_count = count_descendants(element, "TablixRowHierarchy")
            column_group_count = count_descendants(
                element,
                "TablixColumnHierarchy",
            )

            structure_items.add(
                f"{normalized_tag}:rowhierarchies={row_group_count}"
            )
            structure_items.add(
                f"{normalized_tag}:columnhierarchies={column_group_count}"
            )

    return structure_items


def count_descendants(parent: ET.Element, element_name: str) -> int:
    return sum(
        1
        for element in parent.iter()
        if local_name(element.tag) == element_name
    )


def parse_rdl(file_path: Path) -> RDLFeatures:
    """
    Parses one RDL file and returns its extracted comparison features.
    """

    features = RDLFeatures(
        report_name=file_path.stem,
        path=str(file_path.resolve()),
    )

    try:
        tree = ET.parse(file_path)
        root = tree.getroot()

        features.columns = extract_columns(root)
        features.queries, features.query_count = extract_queries(root)
        features.expressions = extract_expressions(root)
        features.parameters = extract_parameters(root)
        features.data_sources = extract_data_sources(root)
        features.dataset_names = extract_dataset_names(root)
        features.structure_items = extract_structure(root)
        features.normalized_xml_hash = normalized_xml_hash(root)

    except ET.ParseError as exc:
        features.parse_error = f"XML parse error: {exc}"

    except OSError as exc:
        features.parse_error = f"File read error: {exc}"

    return features


# ============================================================
# SIMILARITY CALCULATION
# ============================================================

def jaccard_similarity(
    left: set[str],
    right: set[str],
) -> float:
    """
    Calculates Jaccard similarity as a percentage.

    Both empty sets are considered 100% similar because neither report
    contains that feature type.
    """

    if not left and not right:
        return 100.0

    union = left | right

    if not union:
        return 100.0

    intersection = left & right
    return round((len(intersection) / len(union)) * 100, 2)


def calculate_overall_similarity(scores: dict[str, float]) -> float:
    """
    Calculates the weighted overall similarity.
    """

    total_weight = sum(SIMILARITY_WEIGHTS.values())

    if total_weight == 0:
        raise ValueError("Similarity weights cannot total zero.")

    weighted_score = sum(
        scores[metric] * weight
        for metric, weight in SIMILARITY_WEIGHTS.items()
    )

    return round(weighted_score / total_weight, 2)


def get_classification(
    overall_similarity: float,
    exact_feature_duplicate: bool,
) -> str:
    if exact_feature_duplicate:
        return "Exact Feature Duplicate"

    if overall_similarity >= THRESHOLDS["very_high"]:
        return "Very High Similarity"

    if overall_similarity >= THRESHOLDS["high"]:
        return "High Similarity"

    if overall_similarity >= THRESHOLDS["medium"]:
        return "Medium Similarity"

    return "Low Similarity"


def yes_no(value: bool) -> str:
    return "Yes" if value else "No"


def format_list(values: set[str]) -> str:
    if not values:
        return ""

    return "; ".join(sorted(values))


# ============================================================
# REPORT COMPARISON
# ============================================================

def compare_reports(
    report_1: RDLFeatures,
    report_2: RDLFeatures,
) -> dict:
    common_columns = report_1.columns & report_2.columns
    report_1_only_columns = report_1.columns - report_2.columns
    report_2_only_columns = report_2.columns - report_1.columns

    scores = {
        "column": jaccard_similarity(
            report_1.columns,
            report_2.columns,
        ),
        "query": jaccard_similarity(
            report_1.queries,
            report_2.queries,
        ),
        "expression": jaccard_similarity(
            report_1.expressions,
            report_2.expressions,
        ),
        "parameter": jaccard_similarity(
            report_1.parameters,
            report_2.parameters,
        ),
        "data_source": jaccard_similarity(
            report_1.data_sources,
            report_2.data_sources,
        ),
        "structure": jaccard_similarity(
            report_1.structure_items,
            report_2.structure_items,
        ),
    }

    overall_similarity = calculate_overall_similarity(scores)

    exact_feature_duplicate = all(
        score >= THRESHOLDS["exact_feature_duplicate"]
        for score in scores.values()
    )

    retirement_review = (
        overall_similarity >= THRESHOLDS["retirement_review"]
    )

    direct_consolidation_eligible = (
        overall_similarity
        >= THRESHOLDS["direct_consolidation_overall"]
        and scores["column"]
        >= THRESHOLDS["direct_consolidation_column"]
        and scores["query"]
        >= THRESHOLDS["direct_consolidation_query"]
        and scores["structure"]
        >= THRESHOLDS["direct_consolidation_structure"]
    )

    backend_optimization_eligible = (
        scores["query"]
        >= THRESHOLDS["backend_optimization_query"]
        and not (
            len(report_1.queries) == 0
            and len(report_2.queries) == 0
        )
    )

    classification = get_classification(
        overall_similarity,
        exact_feature_duplicate,
    )

    return {
        "Report 1": report_1.report_name,
        "Report 2": report_2.report_name,
        "Overall Similarity %": overall_similarity,
        "Classification": classification,
        "Retirement Review": yes_no(retirement_review),
        "Direct Consolidation Eligible": yes_no(
            direct_consolidation_eligible
        ),
        "Backend Optimization Eligible": yes_no(
            backend_optimization_eligible
        ),
        "Exact Feature Duplicate": yes_no(exact_feature_duplicate),
        "Column Similarity %": scores["column"],
        "Query Similarity %": scores["query"],
        "Expression Similarity %": scores["expression"],
        "Parameter Similarity %": scores["parameter"],
        "Data Source Similarity %": scores["data_source"],
        "Structure Similarity %": scores["structure"],
        "Report 1 Column Count": len(report_1.columns),
        "Report 2 Column Count": len(report_2.columns),
        "Common Column Count": len(common_columns),
        "Common Columns": format_list(common_columns),
        "Report 1 Only Columns": format_list(report_1_only_columns),
        "Report 2 Only Columns": format_list(report_2_only_columns),
        "Report 1 Dataset Count": report_1.dataset_count,
        "Report 2 Dataset Count": report_2.dataset_count,
        "Report 1 Query Count": report_1.query_count,
        "Report 2 Query Count": report_2.query_count,
        "Report 1 Parameter Count": report_1.parameter_count,
        "Report 2 Parameter Count": report_2.parameter_count,
        "Report 1 Structure": report_1.structure_summary,
        "Report 2 Structure": report_2.structure_summary,
        "Report 1 Path": report_1.path,
        "Report 2 Path": report_2.path,
    }


# ============================================================
# INPUT AND OUTPUT
# ============================================================

def find_rdl_files(
    input_folder: Path,
    recursive: bool = True,
) -> list[Path]:
    """
    Finds RDL files in the input folder.

    Args:
        input_folder (Path): The folder to search for RDL files.
        recursive (bool, optional): Whether to search recursively. Defaults to True.

    Returns:
        list[Path]: A list of paths to the found RDL files.
    """

    pattern = "**/*" if recursive else "*"

    files = [
        path
        for path in input_folder.glob(pattern)
        if path.is_file()
        and path.suffix.casefold() in SUPPORTED_EXTENSIONS
    ]

    return sorted(files, key=lambda item: str(item).casefold())


def validate_weights() -> None:
    required_metrics = {
        "column",
        "query",
        "expression",
        "parameter",
        "data_source",
        "structure",
    }

    missing = required_metrics - set(SIMILARITY_WEIGHTS)

    if missing:
        raise ValueError(
            "Missing similarity weights: "
            + ", ".join(sorted(missing))
        )

    if any(weight < 0 for weight in SIMILARITY_WEIGHTS.values()):
        raise ValueError("Similarity weights cannot be negative.")


def write_excel(
    comparison_rows: list[dict],
    parse_results: list[RDLFeatures],
    output_file: Path,
) -> None:
    """
    Writes comparison results and parsing issues to an Excel workbook.
    """

    comparison_df = pd.DataFrame(
        comparison_rows,
        columns=OUTPUT_COLUMNS,
    )

    if not comparison_df.empty:
        comparison_df = comparison_df.sort_values(
            by=[
                "Overall Similarity %",
                "Column Similarity %",
                "Query Similarity %",
            ],
            ascending=[False, False, False],
        )

    error_rows = [
        {
            "Report": result.report_name,
            "Path": result.path,
            "Parse Error": result.parse_error,
        }
        for result in parse_results
        if result.parse_error
    ]

    errors_df = pd.DataFrame(
        error_rows,
        columns=["Report", "Path", "Parse Error"],
    )

    inventory_rows = [
        {
            "Report": result.report_name,
            "Path": result.path,
            "Column Count": len(result.columns),
            "Dataset Count": result.dataset_count,
            "Query Count": result.query_count,
            "Expression Count": len(result.expressions),
            "Parameter Count": result.parameter_count,
            "Data Source Feature Count": len(result.data_sources),
            "Structure Feature Count": len(result.structure_items),
            "Parse Status": (
                "Failed" if result.parse_error else "Successful"
            ),
        }
        for result in parse_results
    ]

    inventory_df = pd.DataFrame(inventory_rows)

    output_file.parent.mkdir(parents=True, exist_ok=True)

    with pd.ExcelWriter(
        output_file,
        engine="openpyxl",
    ) as writer:
        comparison_df.to_excel(
            writer,
            sheet_name="RDL Comparison",
            index=False,
        )

        inventory_df.to_excel(
            writer,
            sheet_name="Report Inventory",
            index=False,
        )

        errors_df.to_excel(
            writer,
            sheet_name="Parse Errors",
            index=False,
        )

        format_excel_sheet(
            writer,
            "RDL Comparison",
            comparison_df,
        )
        format_excel_sheet(
            writer,
            "Report Inventory",
            inventory_df,
        )
        format_excel_sheet(
            writer,
            "Parse Errors",
            errors_df,
        )


def format_excel_sheet(
    writer: pd.ExcelWriter,
    sheet_name: str,
    dataframe: pd.DataFrame,
) -> None:
    """
    Applies filters, freeze panes, number formats, and practical widths.
    """

    worksheet = writer.sheets[sheet_name]

    worksheet.freeze_panes = "A2"
    worksheet.auto_filter.ref = worksheet.dimensions

    for column_cells in worksheet.columns:
        column_letter = column_cells[0].column_letter
        column_name = column_cells[0].value

        max_length = max(
            (
                len(str(cell.value))
                if cell.value is not None
                else 0
            )
            for cell in column_cells
        )

        if column_name in {
            "Common Columns",
            "Report 1 Only Columns",
            "Report 2 Only Columns",
            "Report 1 Structure",
            "Report 2 Structure",
            "Report 1 Path",
            "Report 2 Path",
            "Path",
            "Parse Error",
        }:
            width = min(max(max_length + 2, 20), 60)
        else:
            width = min(max(max_length + 2, 12), 35)

        worksheet.column_dimensions[column_letter].width = width

    percentage_columns = {
        "Overall Similarity %",
        "Column Similarity %",
        "Query Similarity %",
        "Expression Similarity %",
        "Parameter Similarity %",
        "Data Source Similarity %",
        "Structure Similarity %",
    }

    for column_cells in worksheet.columns:
        column_letter = column_cells[0].column_letter
        column_name = column_cells[0].value

        if column_name in percentage_columns:
            for data_cell in worksheet[column_letter][1:]:
                data_cell.number_format = "0.00"


def write_csv(
    comparison_rows: list[dict],
    output_file: Path,
) -> None:
    comparison_df = pd.DataFrame(
        comparison_rows,
        columns=OUTPUT_COLUMNS,
    )

    if not comparison_df.empty:
        comparison_df = comparison_df.sort_values(
            by="Overall Similarity %",
            ascending=False,
        )

    output_file.parent.mkdir(parents=True, exist_ok=True)
    comparison_df.to_csv(
        output_file,
        index=False,
        encoding="utf-8-sig",
    )


# ============================================================
# MAIN PROCESS
# ============================================================

def run_comparison(
    input_folder: Path,
    output_file: Path,
    recursive: bool = True,
) -> None:
    validate_weights()

    if not input_folder.exists():
        raise FileNotFoundError(
            f"Input folder does not exist: {input_folder}"
        )

    if not input_folder.is_dir():
        raise NotADirectoryError(
            f"Input path is not a folder: {input_folder}"
        )

    rdl_files = find_rdl_files(
        input_folder=input_folder,
        recursive=recursive,
    )

    if len(rdl_files) < 2:
        raise ValueError(
            "At least two valid .rdl files are required for comparison."
        )

    print(f"Found {len(rdl_files)} RDL files.")

    parsed_reports: list[RDLFeatures] = []

    for index, file_path in enumerate(rdl_files, start=1):
        print(
            f"Parsing {index}/{len(rdl_files)}: "
            f"{file_path.name}"
        )
        parsed_reports.append(parse_rdl(file_path))

    valid_reports = [
        report
        for report in parsed_reports
        if not report.parse_error
    ]

    failed_reports = [
        report
        for report in parsed_reports
        if report.parse_error
    ]

    if len(valid_reports) < 2:
        raise ValueError(
            "Fewer than two RDL files were parsed successfully."
        )

    total_comparisons = (
        len(valid_reports) * (len(valid_reports) - 1)
    ) // 2

    print(f"Creating {total_comparisons} report comparisons.")

    comparison_rows: list[dict] = []

    for index, (report_1, report_2) in enumerate(
        combinations(valid_reports, 2),
        start=1,
    ):
        print(
            f"Comparing {index}/{total_comparisons}: "
            f"{report_1.report_name} vs {report_2.report_name}"
        )

        comparison_rows.append(
            compare_reports(report_1, report_2)
        )

    output_suffix = output_file.suffix.casefold()

    if output_suffix == ".csv":
        write_csv(
            comparison_rows=comparison_rows,
            output_file=output_file,
        )
    else:
        if output_suffix != ".xlsx":
            output_file = output_file.with_suffix(".xlsx")

        write_excel(
            comparison_rows=comparison_rows,
            parse_results=parsed_reports,
            output_file=output_file,
        )

    print()
    print("Comparison completed.")
    print(f"Successful RDL files: {len(valid_reports)}")
    print(f"Failed RDL files: {len(failed_reports)}")
    print(f"Comparison rows: {len(comparison_rows)}")
    print(f"Output file: {output_file.resolve()}")


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Compare Paginated Report RDL files and generate "
            "a similarity assessment."
        )
    )

    parser.add_argument(
        "input_folder",
        type=Path,
        help="Folder containing the RDL files.",
    )

    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=Path("RDL_Comparison.xlsx"),
        help=(
            "Output .xlsx or .csv file. "
            "Default: RDL_Comparison.xlsx"
        ),
    )

    parser.add_argument(
        "--no-recursive",
        action="store_true",
        help="Do not scan subfolders.",
    )

    return parser.parse_args()


if __name__ == "__main__":
    arguments = parse_arguments()

    run_comparison(
        input_folder=arguments.input_folder,
        output_file=arguments.output,
        recursive=not arguments.no_recursive,
    )