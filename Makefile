IMG=docs/images

all:
	openscad key.scad -D'render=mx' -qo $(IMG)/mx.png
	openscad key.scad -D'render=kh' -qo $(IMG)/kh.png
	openscad key.scad -D'render=choc_v1' -qo $(IMG)/choc_v1.png
	openscad key.scad -D'render=choc_v2' -qo $(IMG)/choc_v2.png
	openscad key.scad -D'render=x' -qo $(IMG)/x.png
	openscad key.scad -D'render=ks33' -qo $(IMG)/ks33.png
