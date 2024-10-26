# RBAC example

package app.rbac

import rego.v1

# By default, deny requests.
default allow := false

allow if {
	# Check that the user is granted every required role
	every required_grant in input.actions {
		some grant in role_grants_for_user

		required_grant == grant
	}
}

# role_grants_for_user is a set of grants for the user identified in the request.
# The 'grant' will be contained if the set 'user_is_granted for every...
role_grants_for_user contains grant if {
	# 'role' assigned an element of the user_roles for this user...
	some role in data.user_roles[input.user]

	# 'grant' assigned a single grant from the grants list for 'role'...
	some grant in data.role_grants[role]
}
