# This is an example PKGBUILD file. Use this as a start to creating your own,
# and remove these comments. For more information, see 'man PKGBUILD'.
# NOTE: Please fill out the license field for your package! If it is unknown,
# then please put 'unknown'.

# Maintainer: "Hisham Abdul Hai hisham.ahai@gmail.com"
pkgname=dmenu-lag-git
pkgver=5.0
pkgrel=1
epoch=
pkgdesc="Generic menu for X. Patched by Hisham"
arch=('any')
url="https://git.suckless.org/dmenu"
license=('MIT')
groups=()
depends=()
makedepends=(git)
checkdepends=()
optdepends=()
provides=(dmenu)
conflicts=('dmenu')
replaces=()
backup=()
options=()
install=
changelog=
source=("git+$URL")
noextract=()
md5sums=('SKIP')
validpgpkeys=()

prepare() {
	cd "$pkgname-$pkgver"
	patch -p1 -i "$srcdir/$pkgname-$pkgver.patch"
}

build() {
	cd "$pkgname-$pkgver"
	./configure --prefix=/usr
	make
}

check() {
	cd "$pkgname-$pkgver"
	make -k check
}

package() {
	cd "$pkgname-$pkgver"
	make DESTDIR="$pkgdir/" install
}
