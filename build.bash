#!/usr/bin/env bash

#
#   One day this script will override the behaviour of `import_by_relative_path`
#   converting all the imports in something which "spits" the imported code.
#   Something similar to what webpack does with import.
#
#   However, this is not that day yet
#

shopt -s extglob

# Chain non-main files
cat ./src/!(main).bash > ./build/__temp

# Add main file
cat ./src/main.bash >> ./build/__temp

# Strip import functions
awk '/^import_by_relative_path\(\) \{/,/^}/{next}1' ./build/__temp > ./build/__temp2
rm ./build/__temp
mv ./build/__temp2 ./build/__temp

# Strip import functions usages
sed -i '/^import_by_relative_path/d' ./build/__temp

# Strip blank lines
sed -i '/^$/d' ./build/__temp

# Strip comments
sed -i '/^\s*#/d' ./build/__temp

# Add Shebang
sed -i '1s/^/\#\!\/usr\/bin\/env bash\n/' ./build/__temp

# Create script
mv ./build/__temp ./build/clean-commit.sh
