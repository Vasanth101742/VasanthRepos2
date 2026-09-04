import os
import re
import xml.etree.ElementTree as ET
from itertools import combinations
from difflib import SequenceMatcher


# ---------------------------------------------------------
# CONFIGURATION
# ---------------------------------------------------------

RDL_FOLDER = r"C:\Paginated Reports Dump as on 24-Aug-2026"

SIMILARITY_THRESHOLD = 80


# ---------------------------------------------------------
# READ AND NORMALIZE RDL
# ---------------------------------------------------------

def read_rdl(file_path):
    """
    Reads an RDL XML file and returns normalized XML text.
    """

    try:
        tree = ET.parse(file_path)
        root = tree.getroot()

        # Remove XML namespace
        for element in root.iter():

            if "}" in element.tag:
                element.tag = element.tag.split("}", 1)[1]

        # Convert XML back to string
        xml_text = ET.tostring(
            root,
            encoding="unicode"
        )

        # Remove whitespace
        xml_text = re.sub(
            r"\s+",
            " ",
            xml_text
        )

        return xml_text.strip()

    except Exception as e:

        print(
            f"Error reading {file_path}: {e}"
        )

        return None


# ---------------------------------------------------------
# CALCULATE SIMILARITY
# ---------------------------------------------------------

def calculate_similarity(text1, text2):

    similarity = SequenceMatcher(
        None,
        text1,
        text2
    ).ratio()

    return similarity * 100


# ---------------------------------------------------------
# MAIN PROGRAM
# ---------------------------------------------------------

def main():

    print("=" * 70)
    print("RDL REPORT SIMILARITY CHECKER")
    print("=" * 70)

    # Get all RDL files
    rdl_files = [
        os.path.join(
            RDL_FOLDER,
            file
        )
        for file in os.listdir(RDL_FOLDER)
        if file.lower().endswith(".rdl")
    ]

    if len(rdl_files) < 2:

        print(
            "\nNeed at least 2 RDL files."
        )

        return

    print(
        f"\nFound {len(rdl_files)} RDL reports."
    )

    # -----------------------------------------------------
    # Load reports
    # -----------------------------------------------------

    reports = {}

    for file_path in rdl_files:

        print(
            f"Reading: "
            f"{os.path.basename(file_path)}"
        )

        content = read_rdl(file_path)

        if content:

            reports[file_path] = content

    # -----------------------------------------------------
    # Compare every report with every other report
    # -----------------------------------------------------

    print("\n")
    print("=" * 100)

    print(
        f"{'REPORT 1':35}"
        f"{'REPORT 2':35}"
        f"{'SIMILARITY':15}"
        f"{'RESULT':15}"
    )

    print("=" * 100)

    for file1, file2 in combinations(
        reports.keys(),
        2
    ):

        similarity = calculate_similarity(
            reports[file1],
            reports[file2]
        )

        report1 = os.path.basename(file1)
        report2 = os.path.basename(file2)

        if similarity >= SIMILARITY_THRESHOLD:

            result = "HIGH"

        elif similarity >= 60:

            result = "MEDIUM"

        else:

            result = "LOW"

        print(
            f"{report1[:34]:35}"
            f"{report2[:34]:35}"
            f"{similarity:>10.2f}%     "
            f"{result}"
        )


# ---------------------------------------------------------
# PROGRAM ENTRY
# ---------------------------------------------------------

if __name__ == "__main__":

    main()
