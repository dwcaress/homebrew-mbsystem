class MbMesaGlu < Formula
  desc "Mesa OpenGL Utility library"
  homepage "https://gitlab.freedesktop.org/mesa/glu"
  url "https://archive.mesa3d.org/glu/glu-9.0.3.tar.xz"
  sha256 "bd43fe12f374b1192eb15fe20e45ff456b9bc26ab57f0eee919f96ca0f8a330f"
  license all_of: ["SGI-B-1.1", "SGI-B-2.0"]
  compatibility_version 1
  head "https://gitlab.freedesktop.org/mesa/glu.git", branch: "master"

  # Installs the same files as the standard mesa-glu formula (include/GL/glu.h,
  # lib/libGLU.dylib) - keep it out of HOMEBREW_PREFIX so it can't collide
  # with mesa-glu's symlinks. MB-System's own build should reference this
  # keg directly, same as it does for mb-mesa.
  keg_only "it installs files that conflict with the standard mesa-glu formula"

  # No bottle: this tap has no bottle-hosting infrastructure of its own, and a
  # bottle block copied from the standard mesa-glu formula (as this one
  # previously was) points Homebrew at homebrew/core's own bottle host for a
  # private-tap formula, which 404s - always build from source instead.

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  # Link against the pinned mb-mesa (26.1.4) keg instead of the standard mesa
  # formula, so libGLU shares the same libGL image as MB-System's own mb-mesa
  # build - otherwise GLU calls silently no-op against a different, unbound
  # GL context (see mbview's blank 3D-perspective-view bug).
  depends_on "dwcaress/mbsystem/mb-mesa"

  def install
    system "meson", "setup", "build", "-Dgl_provider=gl", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <GL/glu.h>

      int main(int argc, char* argv[]) {
        static GLUtriangulatorObj *tobj;
        GLdouble vertex[3], dx, dy, len;
        int i = 0;
        int count = 5;
        tobj = gluNewTess();
        gluBeginPolygon(tobj);
        for (i = 0; i < count; i++) {
          vertex[0] = 1;
          vertex[1] = 2;
          vertex[2] = 0;
          gluTessVertex(tobj, vertex, 0);
        }
        gluEndPolygon(tobj);
        return 0;
      }
    CPP
    system ENV.cxx, "-I#{include}", "test.cpp", "-L#{lib}", "-lGLU"
  end
end
