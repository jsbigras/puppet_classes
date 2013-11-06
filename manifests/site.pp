# The bulk of this should be eventually handled by Foreman - Douglas 11.06.13

# File which contains the global variables
import "global.pp"

# File which contains the roles
import "roles.infrastructure.pp"
import "roles.application.pp"

# File which contains the nodes

# List of stages, used to put priority and set order of execution
stage { [ "pre", "post" ]: }
Stage['pre'] -> Stage['main'] -> Stage['post'] 
