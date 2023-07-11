# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Xtended/manifest.git -b xt -g default,-mips,-darwin,-notdefault
git clone https://github.com/AhmedGamal09/local_manifest.git --depth 1 -b xtended .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom 18
source build/envsetup.sh
lunch xtended_mojito-userdebug
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export BUILD_USER=Ahmed_Gamal
export BUILD_USERNAME=Ahmed_Gamal
export KBUILD_BUILD_USER=Ahmed_Gamal
export KBUILD_BUILD_USERNAME=Ahmed_Gamal
export TZ=Asia/Dhaka #put before last build command
make xtended

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
