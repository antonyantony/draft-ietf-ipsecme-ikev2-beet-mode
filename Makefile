ORG ?= ikev2-beet.org
DOCKER ?= no
ifeq ($(DOCKER),yes)
  DOCKRUN ?= docker run --user $(shell id -u) --network=host -v $$(pwd):/work labn/org-rfc
else
  DOCKRUN ?=
endif
include mk/yang.mk

# Node-based idnits (npm install -g --prefix ~/.local @ietf-tools/idnits)
# Usage: make idnits-node IDNITS_ARGS="-m submission -f errors -f warnings"
.PHONY: idnits-node
idnits-node: $(VBASE).txt
	@command -v idnits >/dev/null || { echo "idnits not found; install with: npm install -g --prefix ~/.local @ietf-tools/idnits"; exit 1; }
	idnits --no-progress $(IDNITS_ARGS) $<
