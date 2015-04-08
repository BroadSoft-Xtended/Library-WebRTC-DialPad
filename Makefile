SHELL := /bin/bash
PATH := node_modules/.bin:$(PATH)

JADE_FILES := $(shell glob-cli "templates/**/*.jade")
STYLUS_FILES := $(shell glob-cli "styles/**/*.styl")

all: symlinks
symlinks: node_modules/bdsft-webrtc-templates.js node_modules/bdsft-webrtc-styles.js node_modules/views

node_modules/views: lib/views
	mkdir -p node_modules/ && ln -sf ../lib/views node_modules/views

node_modules/bdsft-webrtc-templates.js: js/bdsft-webrtc-templates.js
	mkdir -p node_modules/ && ln -sf ../js/bdsft-webrtc-templates.js node_modules/bdsft-webrtc-templates.js

node_modules/bdsft-webrtc-styles.js: js/bdsft-webrtc-styles.js
	mkdir -p node_modules/ && ln -sf ../js/bdsft-webrtc-styles.js node_modules/bdsft-webrtc-styles.js

## Compile styles ##################################################################
styles/css: $(STYLUS_FILES)
	stylus --include-css styles/dialpad.styl -o styles

styles/min.css: styles/css
	cssmin styles/*.css > styles/dialpad.min.css

js/bdsft-webrtc-styles.js: styles/min.css
	mkdir -p js/ && node_modules/webrtc-core/scripts/export-style styles/dialpad.min.css js/bdsft-webrtc-styles.js

## Compile jade templates #########################################################
js/bdsft-webrtc-templates.js: $(JADE_FILES)
	mkdir -p js/ && templatizer -d templates -o js/bdsft-webrtc-templates.js