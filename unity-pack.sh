#! /bin/bash

package_dir=$1
output_path=${2:-'output.unitypackage'}
project_dir=$3
tmp_dir=`mktemp -d -t unitypackage-XXXXXXXX`

[ ! -z $project_dir ] && cd $project_dir

echo "create $output_path from $package_dir"

function make_meta_directory() {
    meta_file=$1
    asset_file=${meta_file%.*}
    guid=`yq e '.guid' $meta_file`
    dir="$tmp_dir/$guid"
    mkdir $dir
    cp $meta_file $dir/asset.meta
    echo $asset_file > $dir/pathname

    if [[ -f $asset_file ]]; then
      cp $asset_file $dir/asset
    elif [[ ! -d $asset_file ]]; then
      rm -fr $dir
      echo "cannot found corresponding asset file $asset_file" >&2
    fi
}

find $package_dir -name "*.meta" -print0 | while IFS= read -r -d '' file; do make_meta_directory "$file"; done

cd $tmp_dir
tar -czvf archtemp.tar.gz * > /dev/null
cd - > /dev/null
mv $tmp_dir/archtemp.tar.gz $output_path
echo $output_path
