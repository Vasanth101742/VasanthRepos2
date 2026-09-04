import os
import re
import csv
import hashlib
import xml.etree.ElementTree as ET
from itertools import combinations
from difflib import SequenceMatcher


# ============================================================
# CONFIGURATION
# ============================================================

RDL_FOLDER = r"C:\Paginated Reports Dump as on 24-Aug-2026\Accounts"

OUTPUT_CSV = os.path.join(RDL_FOLDER, "rdl_similarity_report.csv")

# Reports with similarity >= this value will be highlighted
SIMILARITY_THRESHOLD = 80.0


# ============================================================
# XML HELPERS
# ============================================================

def remove_namespace(tag):
    """
    Convert:
        {namespace}Report
    to:
        Report
    """
    if "}" in tag:
        return tag.split("}", 1)[1]

    return tag


def normalize_text(text):
    """
    Normalize whitespace in XML text.
    """
    if text is None:
        return ""

    text = re.sub(r"\s+", " ", text.strip())

    return text


def normalize_element(element):
    """
    Convert XML into a normalized representation.

    Namespace differences and formatting/whitespace
    differences are ignored.
    """

    tag = remove_namespace(element.tag)

    attributes = []

    for key, value in sorted(element.attrib.items()):
        clean_key = remove_namespace(key)
        clean_value = normalize_text(value)

        attributes.append(
            f"{clean_key}={clean_value}"
        )

    text = normalize_text(element.text)

    children = []

    for child in list(element):
        children.append(normalize_element(child))

    return (
        tag,
        tuple(attributes),
        text,
        tuple(children)
    )


# ============================================================
# RDL PARSING
# ============================================================

def load_rdl(file_path):

    try:

        tree = ET.parse(file_path)

        root = tree.getroot()

        normalized = normalize_element(root)

        return normalized

    except Exception as e:

        print(f"ERROR reading {file_path}: {e}")

        return None


# ============================================================
# STRING REPRESENTATION
# ============================================================

def normalized_to_string(obj):

    if isinstance(obj, tuple):

        return "(" + ",".join(
            normalized_to_string(x)
            for x in obj
        ) + ")"

    return str(obj)


def get_hash(normalized):

    text = normalized_to_string(normalized)

    return hashlib.sha256(
        text.encode("utf-8")
    ).hexdigest()


# ============================================================
# SIMILARITY
# ============================================================

def calculate_similarity(report1, report2):

    str1 = normalized_to_string(report1)
    str2 = normalized_to_string(report2)

    matcher = SequenceMatcher(
        None,
        str1,
        str2
    )

    return matcher.ratio() * 100


# ============================================================
# RDL INFORMATION
# ============================================================

def get_rdl_info(file_path):

    try:

        tree = ET.parse(file_path)

        root = tree.getroot()

        report_name = os.path.splitext(
            os.path.basename(file_path)
        )[0]

        datasets = []
        data_sources = []
        parameters = []
        report_items = []

        for element in root.iter():

            tag = remove_namespace(element.tag)

            # -------------------------
            # DataSets
            # -------------------------

            if tag == "DataSet":

                name = element.attrib.get("Name")

                if name:
                    datasets.append(name)

            # -------------------------
            # DataSources
            # -------------------------

            elif tag == "DataSource":

                name = element.attrib.get("Name")

                if name:
                    data_sources.append(name)

            # -------------------------
            # Parameters
            # -------------------------

            elif tag == "ReportParameter":

                name = element.attrib.get("Name")

                if name:
                    parameters.append(name)

            # -------------------------
            # Report Items
            # -------------------------

            elif tag in [
                "Tablix",
                "Chart",
                "GaugePanel",
                "Map",
                "Textbox",
                "Image",
                "Rectangle",
                "Subreport",
                "Line"
            ]:

                name = element.attrib.get("Name")

                if name:
                    report_items.append(
                        f"{tag}:{name}"
                    )

        return {
            "name": report_name,
            "datasets": sorted(set(datasets)),
            "data_sources": sorted(set(data_sources)),
            "parameters": sorted(set(parameters)),
            "report_items": sorted(set(report_items))
        }

    except Exception as e:

        print(f"ERROR extracting information from {file_path}: {e}")

        return {
            "name": os.path.splitext(
                os.path.basename(file_path)
            )[0],
            "datasets": [],
            "data_sources": [],
            "parameters": [],
            "report_items": []
        }


# ============================================================
# MAIN
# ============================================================

def main():

    print("=" * 70)
    print("RDL REPORT SIMILARITY ANALYSIS")
    print("=" * 70)

    # --------------------------------------------------------
    # Find RDL files
    # --------------------------------------------------------

    rdl_files = [
        os.path.join(RDL_FOLDER, f)
        for f in os.listdir(RDL_FOLDER)
        if f.lower().endswith(".rdl")
    ]

    if len(rdl_files) < 2:

        print(
            "At least two .rdl files are required."
        )

        return

    print(
        f"\nFound {len(rdl_files)} RDL reports."
    )

    # --------------------------------------------------------
    # Load reports
    # --------------------------------------------------------

    reports = {}

    infos = {}

    for file_path in rdl_files:

        print(
            f"Reading: {os.path.basename(file_path)}"
        )

        normalized = load_rdl(file_path)

        if normalized is not None:

            reports[file_path] = normalized

            infos[file_path] = get_rdl_info(
                file_path
            )

    # --------------------------------------------------------
    # Compare every pair
    # --------------------------------------------------------

    results = []

    print("\nComparing reports...\n")

    for file1, file2 in combinations(
        reports.keys(),
        2
    ):

        similarity = calculate_similarity(
            reports[file1],
            reports[file2]
        )

        info1 = infos[file1]
        info2 = infos[file2]

        results.append({

            "Report 1":
                info1["name"],

            "Report 2":
                info2["name"],

            "Similarity %":
                round(similarity, 2),

            "Dataset Match":
                set(info1["datasets"])
                == set(info2["datasets"]),

            "Data Source Match":
                set(info1["data_sources"])
                == set(info2["data_sources"]),

            "Parameter Match":
                set(info1["parameters"])
                == set(info2["parameters"]),

            "Report Items Match":
                set(info1["report_items"])
                == set(info2["report_items"])

        })

    # --------------------------------------------------------
    # Sort by similarity
    # --------------------------------------------------------

    results.sort(
        key=lambda x: x["Similarity %"],
        reverse=True
    )

    # --------------------------------------------------------
    # Display results
    # --------------------------------------------------------

    print("=" * 100)

    print(
        f"{'Report 1':35} "
        f"{'Report 2':35} "
        f"{'Similarity':>12}"
    )

    print("=" * 100)

    for result in results:

        print(
            f"{result['Report 1'][:35]:35} "
            f"{result['Report 2'][:35]:35} "
            f"{result['Similarity %']:>10.2f}%"
        )

    # --------------------------------------------------------
    # Save CSV
    # --------------------------------------------------------

    if results:

        fieldnames = list(
            results[0].keys()
        )

        with open(
            OUTPUT_CSV,
            "w",
            newline="",
            encoding="utf-8"
        ) as csv_file:

            writer = csv.DictWriter(
                csv_file,
                fieldnames=fieldnames
            )

            writer.writeheader()

            writer.writerows(results)

    print("\n" + "=" * 70)

    print(
        f"CSV report created:\n{OUTPUT_CSV}"
    )

    # --------------------------------------------------------
    # Highly similar reports
    # --------------------------------------------------------

    print("\nHighly similar reports:")
    print("-" * 70)

    found = False

    for result in results:

        if (
            result["Similarity %"]
            >= SIMILARITY_THRESHOLD
        ):

            found = True

            print(
                f"{result['Report 1']} "
                f"<--> "
                f"{result['Report 2']} "
                f"= "
                f"{result['Similarity %']:.2f}%"
            )

    if not found:

        print(
            "No reports exceeded "
            f"{SIMILARITY_THRESHOLD}% similarity."
        )


if __name__ == "__main__":
    main()
