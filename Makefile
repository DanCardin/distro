.PHONY: build rebase switch

build:
	bluebuild build ./recipes/recipe.yml

rebase:
	rpm-ostree rebase ostree-image-signed:docker://ghcr.io/dancardin/distro:latest

switch:
	bluebuild switch ./recipes/recipe.yml

qemu:
	podman run --rm --privileged \
		--volume /var/lib/containers/storage:/var/lib/containers/storage \
		--volume $(pwd)/output:/output \
		ghcr.io/osbuild/bootc-image-builder:latest \
		--type qcow2 \
		--local \
		localhost/noctalia-niri:latest
