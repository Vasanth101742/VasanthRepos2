from sharepoint_ManualMethod import SharePoint
import re
import sys,os
from pathlib import PurePath

# 1 args=Sharepoint Folder Name. May Include Sub Folders
#print(sys.argv[0])
FOLDER_NAME =sys.argv[1]
print(FOLDER_NAME)
# 2 args= locate ot remote folder_dest
FOLDER_DEST =sys.argv[2]
print(FOLDER_DEST)
# 3 args= SharePoint file name. This is used only when one file is being downloaded.
#after downloading all the Files, Set the value to "None"
FILE_NAME=sys.argv[3]
print(FILE_NAME)
# 4 args= SharePoint File Name Pattern 
#if no pattern match on the Files required to be downloaded, then set this value to "None"
FILE_NAME_PATTERN=sys.argv[4]
print(FILE_NAME_PATTERN)

def save_file(file_n,file_obj):
    file_dir_path=PurePath(FOLDER_DEST,file_n)
    with open(file_dir_path,'wb') as f:
        f.write(file_obj)

def get_file(file_n,folder):
    file_obj=SharePoint().download_file(file_n,folder)
    save_file(file_n,file_obj)

def get_files(folder):
    files_list=SharePoint()._get_files_list(folder)
    for file in files_list:
        get_file(file.name, folder)

def get_files_by_pattern(keyword,folder):
    files_list=SharePoint()._get_files_list(folder)
    for file in files_list:
        if re.search(keyword, file.name):
            get_file(file.name,folder)

if __name__=='__main__':
    if FILE_NAME !='None':
        get_file(FILE_NAME,FOLDER_NAME)
    elif FILE_NAME_PATTERN !='None':
        get_files_by_pattern(FILE_NAME_PATTERN,FOLDER_NAME)
    else:
        get_files(FOLDER_NAME)
        
    

