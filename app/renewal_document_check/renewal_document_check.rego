package renewal_document_check

import data.app.rbac_with_entity_check
import rego.v1

default allow := false

allow if {
	# check against the rbac policy
	rbac_with_entity_check.allow

	input.is_renewal
}
