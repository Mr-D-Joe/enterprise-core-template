.PHONY: validate

validate:
	./scripts/governance_lint.sh
	./scripts/consistency_check.sh
