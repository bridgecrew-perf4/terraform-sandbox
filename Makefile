# VERSION は環境変数として .git-pr-release-template の中で読み込まれる
VERSION ?= ""
DRY_RUN ?= ""
DRY_RUN_OPTION :=

ifneq ($(DRY_RUN),"")
	DRY_RUN_OPTION="-n"
endif

.PHONY: help
.SILENT: pr-rel-stg pr-rel-prd

help:
	@echo ""
	@echo "[dev] to [stg]"
	@echo "    make pr-rel-stg [DRY_RUN=1]"
	@echo ""
	@echo "[stg] to [prd]"
	@echo "    make pr-rel-prd VERSION=[version] [DRY_RUN=1]"
	@echo ""

pr-rel-stg:
	@echo "Creating PR from develop to staging..."
	@GIT_PR_RELEASE_BRANCH_PRODUCTION=staging \
		GIT_PR_RELEASE_BRANCH_STAGING=develop \
		GIT_PR_RELEASE_TEMPLATE=./.git-pr-release-template \
		git-pr-release ${DRY_RUN_OPTION}
	@echo "done."

check-version:
ifeq ($(VERSION),"")
	@echo "Need to specify VERSION"
	make help
	exit 1
else
	@echo ${VERSION} | grep -E -o '[0-9]+\.[0-9]+\.[0-9]+[-+.[:alnum:]]{0,}' || (echo "invalid version format"; exit 1)
endif

pr-rel-prd: check-version
	@echo "VERSION: ${VERSION}"
	@echo "Creating PR from staging to main..."
	@GIT_PR_RELEASE_BRANCH_PRODUCTION=main \
		GIT_PR_RELEASE_BRANCH_STAGING=staging \
		GIT_PR_RELEASE_TEMPLATE=./.git-pr-release-template \
		git-pr-release ${DRY_RUN_OPTION}
	@echo "done."