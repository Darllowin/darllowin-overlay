# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.95"

IMAGEPIPE_REV="cc9df677831a052a21e4587633d877a1e8850a10"
DNG_OLD_REV="06dc3dab645e12b921f75cff23e0c158e5eed4a9"
DNG_REV="159c7dd836290b896a09665faa1e464559775c09"

CRATES="
	addr2line@0.25.1
	adler2@2.0.1
	adler32@1.2.0
	aho-corasick@1.1.4
	aligned-vec@0.6.4
	aligned@0.4.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.21
	alsa-sys@0.4.0
	alsa@0.11.0
	android_system_properties@0.1.5
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	anyhow@1.0.104
	arbitrary@1.4.2
	arboard@3.6.1
	arg_enum_proc_macro@0.3.4
	arrayref@0.3.9
	arrayvec@0.7.6
	as-slice@0.2.1
	autocfg@1.5.0
	av-scenechange@0.14.1
	av1-grain@0.2.5
	avif-serialize@0.8.8
	backtrace@0.3.76
	bincode@1.3.3
	bindgen@0.72.1
	bit_field@0.10.3
	bitflags@1.3.2
	bitflags@2.13.0
	bitstream-io@4.9.0
	blake3@1.8.4
	block2@0.6.2
	brotli-decompressor@5.0.0
	built@0.8.0
	bumpalo@3.20.2
	bytemuck@1.25.2
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.11.1
	cc@1.4.5
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-if@1.0.4
	chacha20@0.10.0
	chrono@0.4.44
	clang-sys@1.8.1
	clipboard-win@5.4.1
	cmake@0.1.58
	color_quant@1.1.0
	colorchoice@1.0.5
	combine@4.6.7
	const_format@0.2.36
	const_format_proc_macros@0.2.34
	constant_time_eq@0.4.2
	core-foundation-sys@0.8.7
	core2@0.4.0
	core_maths@0.1.1
	coreaudio-rs@0.14.2
	cpal@0.17.3
	cpufeatures@0.3.0
	crc32fast@1.5.0
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	dary_heap@0.3.8
	dasp_sample@0.11.0
	dirs-sys@0.5.0
	dirs@6.0.0
	dispatch2@0.3.1
	document-features@0.2.12
	downcast-rs@1.2.1
	dyn-clone@1.0.20
	either@1.15.0
	encoding_rs@0.8.35
	enumn@0.1.14
	env_filter@2.0.0
	env_logger@0.11.11
	equator-macro@0.4.2
	equator@0.4.2
	equivalent@1.0.2
	errno@0.3.14
	error-code@3.3.2
	exr@1.74.0
	extended@0.1.0
	fast_image_resize@6.1.0
	fax@0.2.6
	fax_derive@0.2.0
	fdeflate@0.3.7
	ffmpeg-next@9.0.0
	ffmpeg-sys-next@9.0.0
	find-msvc-tools@0.1.12
	fixedbitset@0.5.7
	flate2@1.1.9
	foldhash@0.1.5
	foldhash@0.2.0
	fontdue@0.9.4
	futures-core@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	gethostname@1.1.0
	getrandom@0.2.17
	getrandom@0.3.4
	getrandom@0.4.2
	gif@0.13.3
	gif@0.14.1
	gimli@0.32.3
	glob@0.3.3
	half@2.7.1
	hashbrown@0.12.3
	hashbrown@0.15.5
	hashbrown@0.16.1
	heck@0.5.0
	hermit-abi@0.5.2
	hex@0.4.3
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.65
	id-arena@2.3.0
	image-webp@0.2.4
	image@0.24.9
	image@0.25.10
	imgref@1.12.0
	indexmap@1.9.3
	indexmap@2.13.1
	interpolate_name@0.2.4
	is_terminal_polyfill@1.70.2
	itertools@0.13.0
	itertools@0.14.0
	itoa@1.0.18
	jiff-static@0.2.23
	jiff@0.2.23
	jni-sys-macros@0.4.1
	jni-sys@0.3.1
	jni-sys@0.4.1
	jni@0.21.1
	jobserver@0.1.34
	jpeg-decoder@0.3.2
	js-sys@0.3.94
	jxl-bitstream@1.1.0
	jxl-coding@1.0.1
	jxl-color@0.11.0
	jxl-frame@0.13.3
	jxl-grid@0.6.2
	jxl-image@0.13.0
	jxl-jbr@0.2.1
	jxl-modular@0.11.3
	jxl-oxide-common@1.0.0
	jxl-oxide@0.12.6
	jxl-render@0.12.4
	jxl-threadpool@1.0.0
	jxl-vardct@0.11.1
	konst@0.2.20
	konst_macro_rules@0.2.19
	lazy_static@1.5.0
	leb128fmt@0.1.0
	lebe@0.5.3
	libc@0.2.186
	libflate@2.2.1
	libflate_lz77@2.2.0
	libfuzzer-sys@0.4.12
	libjpeg-turbo-rs@0.8.0
	libloading@0.8.9
	libm@0.2.16
	libredox@0.1.15
	linked-hash-map@0.5.6
	linux-raw-sys@0.12.1
	litrs@1.0.0
	lock_api@0.4.14
	log@0.4.34
	loop9@0.1.5
	mach2@0.5.0
	matrixmultiply@0.3.10
	maybe-rayon@0.1.1
	md5@0.8.0
	memchr@2.8.0
	memmap2@0.9.10
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	moxcms@0.8.1
	multicache@0.6.1
	multiversion-macros@0.8.0
	multiversion@0.8.0
	ndarray@0.15.6
	ndk-context@0.1.1
	ndk-sys@0.6.0+11769913
	ndk@0.9.0
	new_debug_unreachable@1.0.6
	nom@7.1.3
	nom@8.0.0
	noop_proc_macro@0.3.0
	ntapi@0.4.3
	num-bigint@0.4.6
	num-complex@0.4.6
	num-derive@0.4.2
	num-integer@0.1.46
	num-iter@0.1.45
	num-rational@0.4.2
	num-traits@0.2.19
	num@0.4.3
	num_cpus@1.17.0
	num_enum@0.7.6
	num_enum_derive@0.7.6
	objc2-app-kit@0.3.2
	objc2-audio-toolbox@0.3.2
	objc2-avf-audio@0.3.2
	objc2-core-audio-types@0.3.2
	objc2-core-audio@0.3.2
	objc2-core-foundation@0.3.2
	objc2-core-graphics@0.3.2
	objc2-encode@4.1.0
	objc2-foundation@0.3.2
	objc2-io-kit@0.3.2
	objc2-io-surface@0.3.2
	objc2@0.6.4
	object@0.37.3
	once_cell@1.21.4
	once_cell_polyfill@1.70.2
	option-ext@0.2.0
	os_pipe@1.2.3
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	paste@1.0.15
	pastey@0.1.1
	percent-encoding@2.3.2
	petgraph@0.8.3
	pin-project-lite@0.2.17
	pkg-config@0.3.32
	png@0.17.16
	png@0.18.1
	portable-atomic-util@0.2.6
	portable-atomic@1.13.1
	ppv-lite86@0.2.21
	prettyplease@0.2.37
	proc-macro-crate@3.5.0
	proc-macro2@1.0.106
	profiling-procmacros@1.0.17
	profiling@1.0.17
	pxfm@0.1.28
	qoi@0.4.1
	quick-error@2.0.1
	quick-xml@0.39.2
	quote@1.0.45
	r-efi@5.3.0
	r-efi@6.0.0
	rand@0.10.2
	rand@0.9.2
	rand_chacha@0.9.0
	rand_core@0.10.0
	rand_core@0.9.5
	rav1e@0.8.1
	ravif@0.13.0
	rawpointer@0.2.1
	rayon-core@1.13.0
	rayon@1.12.0
	redox_syscall@0.5.18
	redox_users@0.5.2
	regex-automata@0.4.14
	regex-syntax@0.8.10
	regex@1.12.3
	rgb@0.8.53
	rle-decode-fast@1.0.3
	rodio@0.22.2
	rpkg-config@0.1.2
	rustc-demangle@0.1.27
	rustc-hash@2.1.2
	rustc_version@0.4.1
	rustix@1.1.4
	rustronomy-core@0.1.0
	rustronomy-fits@0.2.0
	rustversion@1.0.22
	ryu@1.0.23
	same-file@1.0.6
	scopeguard@1.2.0
	sdl3-image-src@3.4.4
	sdl3-image-sys@0.6.4+SDL-image-3.4.4
	sdl3-mixer-src@3.2.4
	sdl3-mixer-sys@0.6.3+SDL-mixer-3.2.4
	sdl3-src@3.4.10
	sdl3-sys@0.6.6+SDL-3.4.10
	sdl3-ttf-src@3.2.2
	sdl3-ttf-sys@0.6.1+SDL-ttf-3.2.2
	sdl3@0.18.4
	semver@1.0.28
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_json@1.0.149
	serde_spanned@0.6.9
	serde_spanned@1.1.1
	serde_yaml@0.8.26
	shlex@1.3.0
	shlex@2.0.1
	simd-adler32@0.3.9
	simd_helpers@0.1.0
	slab@0.4.12
	smallvec@1.15.1
	stable_deref_trait@1.2.1
	symphonia-bundle-flac@0.5.5
	symphonia-bundle-mp3@0.5.5
	symphonia-codec-aac@0.5.5
	symphonia-codec-adpcm@0.5.5
	symphonia-codec-alac@0.5.5
	symphonia-codec-pcm@0.5.5
	symphonia-codec-vorbis@0.5.5
	symphonia-core@0.5.5
	symphonia-format-caf@0.5.5
	symphonia-format-isomp4@0.5.5
	symphonia-format-mkv@0.5.5
	symphonia-format-ogg@0.5.5
	symphonia-format-riff@0.5.5
	symphonia-metadata@0.5.5
	symphonia-utils-xiph@0.5.5
	symphonia@0.5.5
	syn@2.0.117
	syn@3.0.5
	sysinfo@0.39.6
	target-features@0.1.6
	thiserror-impl@1.0.69
	thiserror-impl@2.0.18
	thiserror@1.0.69
	thiserror@2.0.18
	tiff@0.11.3
	tiff@0.9.1
	toml@0.5.11
	toml@0.8.23
	toml@0.9.12+spec-1.1.0
	toml_datetime@0.6.11
	toml_datetime@0.7.5+spec-1.1.0
	toml_datetime@1.1.1+spec-1.1.0
	toml_edit@0.22.27
	toml_edit@0.25.10+spec-1.1.0
	toml_parser@1.1.2+spec-1.1.0
	toml_write@0.1.2
	toml_writer@1.1.1+spec-1.1.0
	tracing-core@0.1.36
	tracing@0.1.44
	tree_magic_mini@3.2.2
	ttf-parser@0.25.1
	unicode-ident@1.0.24
	unicode-xid@0.2.6
	utf8parse@0.2.2
	uuid@1.23.0
	v_frame@0.3.9
	vcpkg@0.2.15
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-futures@0.4.67
	wasm-bindgen-macro-support@0.2.117
	wasm-bindgen-macro@0.2.117
	wasm-bindgen-shared@0.2.117
	wasm-bindgen@0.2.117
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	wayland-backend@0.3.15
	wayland-client@0.31.14
	wayland-protocols-wlr@0.3.12
	wayland-protocols@0.32.12
	wayland-scanner@0.31.10
	wayland-sys@0.31.11
	web-sys@0.3.94
	weezl@0.1.12
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-collections@0.3.2
	windows-core@0.62.2
	windows-future@0.3.2
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.2.1
	windows-numerics@0.3.1
	windows-result@0.4.1
	windows-strings@0.5.1
	windows-sys@0.45.0
	windows-sys@0.60.2
	windows-sys@0.61.2
	windows-targets@0.42.2
	windows-targets@0.53.5
	windows-threading@0.2.1
	windows@0.62.2
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.53.1
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.53.1
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.53.1
	windows_i686_gnullvm@0.53.1
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.53.1
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.53.1
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.53.1
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.53.1
	winnow@0.7.15
	winnow@1.0.1
	winreg@0.56.0
	winres@0.1.12
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	wl-clipboard-rs@0.9.3
	x11rb-protocol@0.13.2
	x11rb@0.13.2
	y4m@0.8.0
	yaml-rust@0.4.5
	zerocopy-derive@0.8.48
	zerocopy@0.8.48
	zmij@1.0.21
	zune-core@0.5.1
	zune-inflate@0.2.54
	zune-jpeg@0.5.15
"

inherit cargo desktop

DESCRIPTION="A lightning-fast cross-platform image viewer and video player"
HOMEPAGE="https://lightningview.app"
SRC_URI="
	https://github.com/dividebysandwich/LightningView/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/dividebysandwich/imagepipe/archive/${IMAGEPIPE_REV}.tar.gz
		-> imagepipe-${IMAGEPIPE_REV}.tar.gz
	https://github.com/dividebysandwich/dnglab/archive/${DNG_OLD_REV}.tar.gz
		-> dnglab-${DNG_OLD_REV}.tar.gz
	https://github.com/dividebysandwich/dnglab/archive/${DNG_REV}.tar.gz
		-> dnglab-${DNG_REV}.tar.gz
	${CARGO_CRATE_URIS}
"

# GitHub tarball unpacks to LightningView-${PV}, not ${P}
S="${WORKDIR}/LightningView-${PV}"

LICENSE="GPL-2"
# Dependent crate licenses
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0
	CC0-1.0 GPL-3+ ISC LGPL-2.1 LGPL-3 MIT MPL-2.0 Unicode-3.0 Unlicense
	UoI-NCSA WTFPL-2 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa pipewire pulseaudio wayland X"
REQUIRED_USE="|| ( X wayland )"

DEPEND="
	media-video/ffmpeg:=
	media-libs/fontconfig:=
	media-libs/libglvnd
	x11-libs/libdrm
	x11-libs/libxkbcommon:=
	X? (
		x11-libs/cairo
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXft
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXScrnSaver
		x11-libs/libXtst
		x11-libs/libXxf86vm
		x11-libs/pango
	)
	wayland? (
		dev-libs/libinput
		dev-libs/wayland
	)
	alsa? ( media-libs/alsa-lib )
	pipewire? ( media-video/pipewire:= )
	pulseaudio? ( media-libs/libpulse:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

# SDL3-src builds native code; ignore pre-stripped Rust binary QA check
QA_FLAGS_IGNORED="usr/bin/lightningview"

src_unpack() {
	cargo_src_unpack

	# Git-sourced crates are fetched via SRC_URI and placed into the cargo
	# "gentoo" directory source alongside the crates.io crates.
	mv "${WORKDIR}/imagepipe-${IMAGEPIPE_REV}" "${ECARGO_VENDOR}/imagepipe-0.5.0" || die
	mv "${WORKDIR}/dnglab-${DNG_OLD_REV}/rawler" "${ECARGO_VENDOR}/rawler-0.7.2" || die
	mv "${WORKDIR}/dnglab-${DNG_REV}/rawler" "${ECARGO_VENDOR}/rawler-0.8.0" || die

	# rawler's manifest inherits [workspace.lints] from the dnglab workspace
	# root, which does not exist once moved into the vendor dir. Inline the
	# inherited values (the same normalization `cargo vendor` performs).
	for pkg in rawler-0.7.2 rawler-0.8.0; do
		sed -i -e '/^\[lints\]$/,/^$/d' "${ECARGO_VENDOR}/${pkg}/Cargo.toml" || die
		cat >> "${ECARGO_VENDOR}/${pkg}/Cargo.toml" <<-EOF || die

		[lints.clippy]
		collapsible_if = "allow"
		unwrap_used = "warn"
		EOF
	done

	for pkg in imagepipe-0.5.0 rawler-0.7.2 rawler-0.8.0; do
		cat > "${ECARGO_VENDOR}/${pkg}/.cargo-checksum.json" <<-EOF || die
		{"package":null,"files":{}}
		EOF
	done
}

src_prepare() {
	default

	# Point the git dependencies at the copies in the "gentoo" vendor dir so
	# nothing is cloned over the network during the build.
	cat >> "${ECARGO_HOME}/config.toml" <<-EOF || die
	[source."git+https://github.com/dividebysandwich/imagepipe?rev=cc9df677"]
	git = "https://github.com/dividebysandwich/imagepipe"
	rev = "cc9df677"
	replace-with = "gentoo"

	[source."git+https://patched@github.com/dividebysandwich/dnglab.git?rev=06dc3dab"]
	git = "https://patched@github.com/dividebysandwich/dnglab.git"
	rev = "06dc3dab"
	replace-with = "gentoo"

	[source."git+https://patched@github.com/dividebysandwich/dnglab.git?rev=159c7dd"]
	git = "https://patched@github.com/dividebysandwich/dnglab.git"
	rev = "159c7dd"
	replace-with = "gentoo"
	EOF

	# Shader sources are checked in as prebuilt SPIR-V; never require a
	# shader compiler on the build machine.
	export LV_FORCE_PREBUILT_SHADERS=1

	# cmake-rs crate (sdl3-src) finds cmake via $PATH. Inject a wrapper
	# that passes SDL backend-disable flags for the configure step only.
	if ! use X || ! use wayland; then
		mkdir -p "${T}/cmake-wrap" || die
		cat > "${T}/cmake-wrap/cmake" <<-EOS || die
		#!/bin/sh
		case "\$*" in
			*--build*|*--install*|*-E*)
				exec /usr/bin/cmake "\$@"
				;;
		esac
		flags=
		$(if ! use X;       then echo 'flags="$flags -DSDL_X11=OFF"'; fi)
		$(if ! use wayland; then echo 'flags="$flags -DSDL_WAYLAND=OFF"'; fi)
		exec /usr/bin/cmake \$flags "\$@"
		EOS
		chmod +x "${T}/cmake-wrap/cmake" || die
		export PATH="${T}/cmake-wrap:${PATH}"
	fi
}

src_install() {
	# --frozen: lockfile is complete; all deps come from the local source dirs
	cargo_src_install --frozen

	domenu "${S}/lightningview.desktop"
	doicon "${S}/lightningview.png"
}

pkg_postinst() {
	einfo "To force a specific video backend at runtime:"
	einfo "  SDL_VIDEO_DRIVER=wayland lightningview <file>"
	einfo "  SDL_VIDEO_DRIVER=x11 lightningview <file>"
	einfo "Config file: ~/.config/lightningview/config.toml"
}
