## THIS IS A COMMENT TO TEST IF THE POLICY GOT UPDATED

# RBAC + ABAC (entity groups) example
# --
#
# This example defines an RBAC + ABAC model for evaluating whether a user can
# 1. perform a set of specific actions
# 2. perform said action on a resource belonging to a specific entity

package app.rbac_with_entity_check

import data.app.rbac
import rego.v1

default allow := false

allow if {
	# check against the rbac policy
	rbac.allow

	# Check if the user has access to the specific entity (property)
	input.entity in entity_grants_for_user
}

entity_grants_for_user contains entity if {
	some entity in data.entity_grants[input.user]
}
