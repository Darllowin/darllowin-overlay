EAPI=8

RUST_MIN_VER="1.92"

CRATES="
	adler2@2.0.1
	aho-corasick@1.1.5
	ashpd@0.13.13
	async-broadcast@0.7.2
	async-channel@2.5.0
	async-recursion@1.1.1
	async-trait@0.1.92
	atomic_refcell@0.1.14
	autocfg@1.5.1
	bitflags@2.13.1
	block@0.1.6
	bumpalo@3.20.3
	bytes@1.12.1
	cairo-rs@0.22.9
	cairo-sys-rs@0.22.9
	cc@1.4.5
	cfg-expr@0.20.9
	cfg-if@1.0.4
	concurrent-queue@2.5.0
	crossbeam-utils@0.8.22
	either@1.18.0
	endi@1.1.1
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	equivalent@1.0.2
	errno@0.3.14
	event-listener-strategy@0.5.4
	event-listener@5.4.2
	fastrand@2.5.0
	field-offset@0.3.6
	find-msvc-tools@0.1.12
	futures-channel@0.3.34
	futures-core@0.3.34
	futures-executor@0.3.34
	futures-io@0.3.34
	futures-lite@2.6.1
	futures-macro@0.3.34
	futures-task@0.3.34
	futures-util@0.3.34
	gdk-pixbuf-sys@0.22.9
	gdk-pixbuf@0.22.0
	gdk4-sys@0.11.5
	gdk4-wayland-sys@0.11.5
	gdk4-wayland@0.11.5
	gdk4@0.11.5
	getrandom@0.4.3
	gettext-rs@0.8.0
	gettext-sys@0.26.0
	gio-sys@0.22.9
	gio@0.22.10
	glib-build-tools@0.22.8
	glib-macros@0.22.9
	glib-sys@0.22.9
	glib@0.22.10
	gobject-sys@0.22.9
	graphene-rs@0.22.8
	graphene-sys@0.22.9
	gsk4-sys@0.11.5
	gsk4@0.11.5
	gstreamer-allocators-sys@0.25.4
	gstreamer-allocators@0.25.4
	gstreamer-audio-sys@0.25.4
	gstreamer-audio@0.25.4
	gstreamer-base-sys@0.25.4
	gstreamer-base@0.25.4
	gstreamer-pbutils-sys@0.25.4
	gstreamer-pbutils@0.25.4
	gstreamer-sys@0.25.4
	gstreamer-tag-sys@0.25.4
	gstreamer-tag@0.25.2
	gstreamer-video-sys@0.25.4
	gstreamer-video@0.25.4
	gstreamer@0.25.4
	gtk4-macros@0.11.5
	gtk4-sys@0.11.5
	gtk4@0.11.5
	hashbrown@0.17.1
	heck@0.5.0
	hex@0.4.3
	indexmap@2.14.2
	itertools@0.15.0
	js-sys@0.3.105
	kamadak-exif@0.6.1
	kstring@2.0.2
	lazy_static@1.5.0
	libadwaita-sys@0.9.2
	libadwaita@0.9.2
	libc@0.2.189
	libseccomp-sys@0.3.0
	libseccomp@0.4.0
	linux-raw-sys@0.12.1
	locale_config@0.3.0
	malloc_buf@0.0.6
	memchr@2.8.3
	memoffset@0.9.1
	miniz_oxide@0.9.1
	mio@1.2.3
	muldiv@1.0.1
	mutate_once@0.1.2
	num-integer@0.1.47
	num-rational@0.4.2
	num-traits@0.2.19
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.21.4
	option-operations@0.6.1
	ordered-stream@0.2.0
	pango-sys@0.22.9
	pango@0.22.9
	parking@2.2.1
	pastey@0.2.3
	pin-project-lite@0.2.17
	pkg-config@0.3.34
	proc-macro-crate@3.5.0
	proc-macro2@1.0.107
	quote@1.0.47
	r-efi@6.0.0
	regex-automata@0.4.18
	regex-syntax@0.8.11
	regex@1.13.1
	rustc_version@0.4.1
	rustix@1.1.4
	rustversion@1.0.23
	semver@1.0.28
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_repr@0.1.21
	serde_spanned@1.1.1
	shlex@2.0.1
	signal-hook-registry@1.4.8
	slab@0.4.12
	smallvec@1.16.0
	socket2@0.6.5
	sourceview5-sys@0.11.2
	sourceview5@0.11.2
	static_assertions@1.1.0
	syn@2.0.119
	syn@3.0.5
	system-deps@7.0.8
	system-deps@9.0.0
	target-lexicon@0.13.5
	temp-dir@0.1.16
	tempfile@3.27.0
	thiserror-impl@2.0.20
	thiserror@2.0.20
	tokio@1.53.1
	toml@1.1.5+spec-1.1.0
	toml_datetime@1.1.1+spec-1.1.0
	toml_edit@0.25.13+spec-1.1.0
	toml_parser@1.1.3+spec-1.1.0
	toml_writer@1.1.2+spec-1.1.0
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing@0.1.44
	uds_windows@1.2.1
	unicode-ident@1.0.24
	uuid@1.26.0
	version-compare@0.2.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasm-bindgen-macro-support@0.2.128
	wasm-bindgen-macro@0.2.128
	wasm-bindgen-shared@0.2.128
	wasm-bindgen@0.2.128
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.61.2
	winnow@1.0.4
	zbus@5.19.0
	zbus_macros@5.19.0
	zbus_names@4.3.4
	zcheapstr@1.1.0
	zvariant@5.15.0
	zvariant_derive@5.15.0
	zvariant_utils@4.2.0
"

inherit cargo gnome2-utils xdg

DESCRIPTION="A GTK4 file manager with a file chooser portal backend"
HOMEPAGE="https://github.com/sachesi/spiral"

SRC_URI="
	https://github.com/sachesi/spiral/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3+"
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 MIT Unicode-3.0
"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=gui-libs/gtk-4.22.0:4
	>=gui-libs/libadwaita-1.9.0:=
	gui-libs/gtksourceview:5
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-plugins/gst-plugin-gtk4:1.0
	sys-apps/bubblewrap
	sys-libs/libseccomp
"

RDEPEND+="
	sys-apps/xdg-desktop-portal
"

DEPEND="${RDEPEND}"

BDEPEND="
	dev-build/just
	dev-util/blueprint-compiler
	sys-devel/gettext
	virtual/pkgconfig
"

src_compile() {
	export SPIRAL_LIBEXECDIR="/usr/libexec/spiral"
	export SPIRAL_LOCALEDIR="/usr/share/locale"

	cargo_src_compile
}

src_install() {
	export PREFIX="/usr"
	export DESTDIR="${D}"

	just \
		prefix="/usr" \
		libexec="/usr/libexec/spiral" \
		install
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
