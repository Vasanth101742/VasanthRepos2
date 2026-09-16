import os
import re
import csv
import math
import hashlib
import xml.etree.ElementTree as ET
from collections import Counter
from itertools import combinations


# ============================================================
# CONFIGURATION
# ============================================================

RDL_FOLDER = r"C:\Paginated Reports Dump as on 24-Aug-2026"
OUTPUT_CSV = os.path.join(
    RDL_FOLDER,
    "rdl_report_similarity_corrected_all_pairs.csv"
)
ERROR_CSV = os.path.join(RDL_FOLDER, "rdl_read_errors.csv")
INCLUDE_SUBFOLDERS = True

# Every pair is written to CSV. For 417 valid reports: 86,736 rows.
WEIGHTS = {
    "columns": 0.25,
    "queries": 0.25,
    "expressions": 0.15,
    "parameters": 0.10,
    "data_sources": 0.10,
    "structure": 0.15,
}

REPORT_ITEM_TAGS = {
    "Tablix", "Chart", "GaugePanel", "Map", "Textbox", "Image",
    "Rectangle", "Subreport", "Line", "List", "Table", "Matrix"
}

STRUCTURE_TAGS = {
    "RowGroup", "ColumnGroup", "TablixRow", "TablixColumn",
    "ChartSeries", "ChartCategoryHierarchy", "ChartSeriesHierarchy",
    "Grouping", "SortExpression", "Filter", "Visibility"
}

SQL_STOPWORDS = {
    "select", "from", "where", "and", "or", "as", "on", "join", "left",
    "right", "inner", "outer", "full", "cross", "group", "by", "order",
    "having", "union", "all", "distinct", "case", "when", "then", "else",
    "end", "is", "null", "not", "in", "exists", "like", "between", "into",
    "with", "top", "asc", "desc", "true", "false"
}


# ============================================================
# HELPERS
# ============================================================

def local_name(tag):
    return tag.split("}", 1)[-1] if "}" in tag else tag


def clean_text(value):
    if value is None:
        return ""
    return re.sub(r"\s+", " ", value).strip().lower()


def find_text(element, wanted_tag):
    for child in element.iter():
        if local_name(child.tag) == wanted_tag:
            return clean_text(child.text)
    return ""


def format_list(values, limit=25):
    values = sorted(values)
    if not values:
        return "None"
    if len(values) <= limit:
        return ", ".join(values)
    return ", ".join(values[:limit]) + f" ... (+{len(values) - limit} more)"


def hash_parts(parts):
    joined = "\x1f".join(sorted(parts))
    return hashlib.sha256(joined.encode("utf-8")).hexdigest()


# ============================================================
# QUERY AND EXPRESSION NORMALIZATION
# ============================================================

def normalize_query(query):
    query = clean_text(query)
    query = re.sub(r"--.*?$", " ", query, flags=re.MULTILINE)
    query = re.sub(r"/\*.*?\*/", " ", query, flags=re.DOTALL)
    query = re.sub(r"\s+", " ", query).strip()
    return query


def tokenize_query(query):
    """
    Preserve identifiers and operators. Generalize only literal values.
    Query comparison is performed query-by-query, not using one merged token set.
    """
    query = normalize_query(query)
    query = re.sub(r"'(?:''|[^'])*'", " string_literal ", query)
    query = re.sub(r"\b\d+(?:\.\d+)?\b", " number_literal ", query)
    tokens = re.findall(
        r"[a-z_][a-z0-9_.$#]*|<=|>=|<>|!=|=|<|>|\+|-|\*|/",
        query
    )
    return {token for token in tokens if token not in SQL_STOPWORDS}


def normalize_expression(expression):
    expression = clean_text(expression)
    expression = re.sub(r'"(?:""|[^"])*"', '"string_literal"', expression)
    expression = re.sub(r"\b\d+(?:\.\d+)?\b", "number_literal", expression)
    return expression


# ============================================================
# FEATURE EXTRACTION
# ============================================================

def extract_report_features(file_path):
    tree = ET.parse(file_path)
    root = tree.getroot()

    columns = set()
    query_token_sets = []
    normalized_queries = []
    expressions = set()
    parameters = set()
    data_sources = set()
    structure = Counter()
    dataset_names = set()

    for element in root.iter():
        tag = local_name(element.tag)

        if tag == "DataSet":
            name = clean_text(element.attrib.get("Name"))
            if name:
                dataset_names.add(name)

        elif tag == "Field":
            field_name = clean_text(element.attrib.get("Name"))
            data_field = find_text(element, "DataField")
            field_value = find_text(element, "Value")
            if field_name:
                columns.add(field_name)
            if data_field:
                columns.add(data_field)
            if field_value.startswith("="):
                expressions.add(normalize_expression(field_value))

        elif tag == "CommandText":
            query = normalize_query(element.text)
            if query:
                normalized_queries.append(query)
                query_token_sets.append(tokenize_query(query))

        elif tag == "DataSource":
            name = clean_text(element.attrib.get("Name"))
            reference = find_text(element, "DataSourceReference")
            provider = find_text(element, "DataProvider")
            connection = find_text(element, "ConnectString")

            if name:
                data_sources.add("name:" + name)
            if reference:
                data_sources.add("reference:" + reference)
            if provider:
                data_sources.add("provider:" + provider)
            if connection:
                connection_hash = hashlib.sha256(
                    connection.encode("utf-8")
                ).hexdigest()[:16]
                data_sources.add("connection_hash:" + connection_hash)

        elif tag == "ReportParameter":
            name = clean_text(element.attrib.get("Name"))
            data_type = find_text(element, "DataType") or "unknown"
            nullable = find_text(element, "Nullable") or "false"
            multi_value = find_text(element, "MultiValue") or "false"
            allow_blank = find_text(element, "AllowBlank") or "false"
            if name:
                parameters.add(
                    f"{name}|type={data_type}|nullable={nullable}|"
                    f"multivalue={multi_value}|blank={allow_blank}"
                )

        element_text = clean_text(element.text)
        if element_text.startswith("="):
            expressions.add(normalize_expression(element_text))

        if tag in REPORT_ITEM_TAGS or tag in STRUCTURE_TAGS:
            structure[tag.lower()] += 1

    fingerprint_parts = (
        ["column:" + x for x in columns]
        + ["query:" + x for x in normalized_queries]
        + ["expression:" + x for x in expressions]
        + ["parameter:" + x for x in parameters]
        + ["source:" + x for x in data_sources]
        + [f"structure:{key}:{value}" for key, value in structure.items()]
    )

    return {
        "name": os.path.splitext(os.path.basename(file_path))[0],
        "path": file_path,
        "columns": columns,
        "query_token_sets": query_token_sets,
        "queries": normalized_queries,
        "expressions": expressions,
        "parameters": parameters,
        "data_sources": data_sources,
        "structure": structure,
        "dataset_names": dataset_names,
        "fingerprint": hash_parts(fingerprint_parts),
    }


# ============================================================
# SIMILARITY FUNCTIONS
# ============================================================

def jaccard_similarity(set1, set2):
    if not set1 and not set2:
        return 100.0
    union = set1 | set2
    return len(set1 & set2) / len(union) * 100.0 if union else 100.0


def query_collection_similarity(queries1, queries2):
    """
    Match each query to its best unused query in the other report.
    Unmatched queries score zero. This prevents all report queries from
    being merged into one token set and incorrectly scoring 100%.
    """
    if not queries1 and not queries2:
        return 100.0
    if not queries1 or not queries2:
        return 0.0

    candidates = []
    for index1, query1 in enumerate(queries1):
        for index2, query2 in enumerate(queries2):
            score = jaccard_similarity(query1, query2)
            candidates.append((score, index1, index2))

    candidates.sort(reverse=True)
    used1 = set()
    used2 = set()
    matched_scores = []

    for score, index1, index2 in candidates:
        if index1 not in used1 and index2 not in used2:
            used1.add(index1)
            used2.add(index2)
            matched_scores.append(score)

    denominator = max(len(queries1), len(queries2))
    return sum(matched_scores) / denominator if denominator else 100.0


def weighted_counter_similarity(counter1, counter2):
    keys = set(counter1) | set(counter2)
    if not keys:
        return 100.0
    intersection = sum(min(counter1[key], counter2[key]) for key in keys)
    union = sum(max(counter1[key], counter2[key]) for key in keys)
    return intersection / union * 100.0 if union else 100.0


# ============================================================
# CORRECTED CLASSIFICATION
# ============================================================

def classify_report_pair(
    overall,
    column_score,
    query_score,
    expression_score,
    parameter_score,
    data_source_score,
    structure_score,
    exact_feature_duplicate,
):
    """Use mandatory gates instead of classifying only by weighted average."""

    if exact_feature_duplicate:
        return "Exact Business-Feature Duplicate", "Strong Candidate"

    if (
        overall >= 95.0
        and column_score >= 90.0
        and query_score >= 90.0
        and expression_score >= 90.0
        and parameter_score >= 90.0
        and data_source_score >= 90.0
        and structure_score >= 85.0
    ):
        return "Near Duplicate", "Strong Candidate"

    if (
        overall >= 85.0
        and column_score >= 80.0
        and query_score >= 80.0
        and expression_score >= 80.0
        and parameter_score >= 70.0
        and data_source_score >= 70.0
        and structure_score >= 70.0
    ):
        return "Highly Similar", "Review for Consolidation"

    if (
        column_score >= 80.0
        and query_score >= 80.0
        and structure_score < 70.0
    ):
        return "Common Data, Different Report", "Optimize Backend Only"

    if (
        overall >= 70.0
        and column_score >= 60.0
        and query_score >= 60.0
        and structure_score >= 45.0
    ):
        return "Similar", "Review Manually"

    if overall >= 60.0:
        return "Partially Similar", "Low Priority Review"

    return "Different", "No"


def compare_reports(report1, report2):
    column_score = jaccard_similarity(report1["columns"], report2["columns"])
    query_score = query_collection_similarity(
        report1["query_token_sets"], report2["query_token_sets"]
    )
    expression_score = jaccard_similarity(
        report1["expressions"], report2["expressions"]
    )
    parameter_score = jaccard_similarity(
        report1["parameters"], report2["parameters"]
    )
    data_source_score = jaccard_similarity(
        report1["data_sources"], report2["data_sources"]
    )
    structure_score = weighted_counter_similarity(
        report1["structure"], report2["structure"]
    )

    overall = (
        column_score * WEIGHTS["columns"]
        + query_score * WEIGHTS["queries"]
        + expression_score * WEIGHTS["expressions"]
        + parameter_score * WEIGHTS["parameters"]
        + data_source_score * WEIGHTS["data_sources"]
        + structure_score * WEIGHTS["structure"]
    )

    exact_feature_duplicate = report1["fingerprint"] == report2["fingerprint"]

    classification, retirement_review = classify_report_pair(
        overall,
        column_score,
        query_score,
        expression_score,
        parameter_score,
        data_source_score,
        structure_score,
        exact_feature_duplicate,
    )

    common_columns = report1["columns"] & report2["columns"]
    report1_only = report1["columns"] - report2["columns"]
    report2_only = report2["columns"] - report1["columns"]

    direct_consolidation = retirement_review in {
        "Strong Candidate", "Review for Consolidation"
    }
    backend_optimization = retirement_review == "Optimize Backend Only"

    return {
        "Report 1": report1["name"],
        "Report 2": report2["name"],
        "Overall Similarity %": round(overall, 2),
        "Classification": classification,
        "Retirement Review": retirement_review,
        "Direct Consolidation Eligible": "Yes" if direct_consolidation else "No",
        "Backend Optimization Eligible": "Yes" if backend_optimization else "No",
        "Exact Feature Duplicate": "Yes" if exact_feature_duplicate else "No",
        "Column Similarity %": round(column_score, 2),
        "Query Similarity %": round(query_score, 2),
        "Expression Similarity %": round(expression_score, 2),
        "Parameter Similarity %": round(parameter_score, 2),
        "Data Source Similarity %": round(data_source_score, 2),
        "Structure Similarity %": round(structure_score, 2),
        "Report 1 Column Count": len(report1["columns"]),
        "Report 2 Column Count": len(report2["columns"]),
        "Common Column Count": len(common_columns),
        "Common Columns": format_list(common_columns),
        "Report 1 Only Columns": format_list(report1_only),
        "Report 2 Only Columns": format_list(report2_only),
        "Report 1 Dataset Count": len(report1["dataset_names"]),
        "Report 2 Dataset Count": len(report2["dataset_names"]),
        "Report 1 Query Count": len(report1["queries"]),
        "Report 2 Query Count": len(report2["queries"]),
        "Report 1 Parameter Count": len(report1["parameters"]),
        "Report 2 Parameter Count": len(report2["parameters"]),
        "Report 1 Structure": format_list(
            {f"{key}:{value}" for key, value in report1["structure"].items()}
        ),
        "Report 2 Structure": format_list(
            {f"{key}:{value}" for key, value in report2["structure"].items()}
        ),
        "Report 1 Path": report1["path"],
        "Report 2 Path": report2["path"],
    }


# ============================================================
# DISCOVERY AND OUTPUT
# ============================================================

def find_rdl_files(folder):
    if INCLUDE_SUBFOLDERS:
        files = []
        for root, _, names in os.walk(folder):
            for name in names:
                if name.lower().endswith(".rdl"):
                    files.append(os.path.join(root, name))
        return sorted(files)

    return sorted(
        os.path.join(folder, name)
        for name in os.listdir(folder)
        if name.lower().endswith(".rdl")
    )


def write_csv(path, rows):
    if not rows:
        return
    with open(path, "w", newline="", encoding="utf-8-sig") as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


def main():
    print("=" * 78)
    print("CORRECTED RDL BUSINESS AND REPORT SIMILARITY")
    print("=" * 78)

    if abs(sum(WEIGHTS.values()) - 1.0) > 0.000001:
        print("ERROR: WEIGHTS must total 1.00")
        return

    if not os.path.isdir(RDL_FOLDER):
        print(f"ERROR: Folder not found: {RDL_FOLDER}")
        return

    rdl_files = find_rdl_files(RDL_FOLDER)
    if len(rdl_files) < 2:
        print("At least two RDL files are required.")
        return

    expected_pairs = len(rdl_files) * (len(rdl_files) - 1) // 2
    print(f"Found {len(rdl_files)} RDL files.")
    print(f"Potential comparisons: {expected_pairs:,}")
    print("\nExtracting report features...")

    reports = []
    errors = []

    for index, file_path in enumerate(rdl_files, start=1):
        try:
            reports.append(extract_report_features(file_path))
        except Exception as error:
            errors.append({"File": file_path, "Error": str(error)})

        print(
            f"\rParsed {index}/{len(rdl_files)} reports",
            end="",
            flush=True,
        )

    print()

    if errors:
        write_csv(ERROR_CSV, errors)
        print(f"Skipped {len(errors)} unreadable files. See: {ERROR_CSV}")

    if len(reports) < 2:
        print("Less than two valid reports were loaded.")
        return

    total_pairs = len(reports) * (len(reports) - 1) // 2
    results = []
    print(f"\nComparing {total_pairs:,} report pairs...")

    for completed, (report1, report2) in enumerate(
        combinations(reports, 2), start=1
    ):
        # Every pair is retained, including scores below 60%.
        results.append(compare_reports(report1, report2))

        if completed % 500 == 0 or completed == total_pairs:
            percentage = completed / total_pairs * 100
            print(
                f"\rCompared {completed:,}/{total_pairs:,} pairs "
                f"({percentage:.1f}%)",
                end="",
                flush=True,
            )

    print()

    results.sort(
        key=lambda row: (
            row["Direct Consolidation Eligible"] == "Yes",
            row["Overall Similarity %"],
            row["Structure Similarity %"],
        ),
        reverse=True,
    )

    try:
        write_csv(OUTPUT_CSV, results)
    except PermissionError:
        print("ERROR: Close the existing output CSV in Excel and run again.")
        return

    direct_count = sum(
        row["Direct Consolidation Eligible"] == "Yes" for row in results
    )
    backend_count = sum(
        row["Backend Optimization Eligible"] == "Yes" for row in results
    )

    print(f"\nOutput created: {OUTPUT_CSV}")
    print(f"All comparison pairs written: {len(results):,}")
    print(f"Direct consolidation candidates: {direct_count:,}")
    print(f"Backend-only optimization candidates: {backend_count:,}")
    print("\nDo not retire reports without usage and business validation.")


if __name__ == "__main__":
    main()
