:: Apply patches
cd ..\..
git submodule update "dep/hbaoplus"
cd dep\hbaoplus
git am --3way --ignore-space-change --keep-cr < ..\..\pkg\hbaoplus\0001-Migrate-projects-to-Visual-Studio-2022.patch
