# OPA Policy Prototyping

## Setup

1. Make sure you have OPA installed - see [here](https://www.openpolicyagent.org/docs/latest/#running-opa).
2. You can verify your installation by running [`opa_run`](https://www.openpolicyagent.org/docs/latest/#3-try-opa-run-interactive) or [`opa eval`](https://www.openpolicyagent.org/docs/latest/#2-try-opa-eval).
3. Make a copy of `example_data.json` and `example_input.json` and name them `data.json` and `input.json`, respectively.
   1. These files will act as your test datastore and input for the OPA extension (or CLI if you choose). Additionally, they will be ignored by git, so you can make whatever changes you want without git tracking them.
4. (OPTIONAL) install the [OPA VSCode extension](https://marketplace.visualstudio.com/items?itemName=tsandall.opa) and [Regal](https://docs.styra.com/regal).

## Testing

### VSCode

If you choose to set up the VSCode extension, you should be able to open a rego policy and run `OPA: Evaluate Package` and see the result in a new `output.jsonc` file.

### CLI

If you are just using the OPA CLI, you should be able to run the following command from the root of this repo:

```bash
opa eval --data=./app/rbac/rbac.rego 'data.app.rbac.allow' --data=data.json --input=input.json
```

The output should look something like this:

```json
{
  "result": [
    {
      "expressions": [
        {
          "value": true,
          "text": "data.app.rbac.allow",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}
```

### Server

To run the OPA server with all of the policies loaded and the data from `data.json`, run the following command from the root of this repo:

```bash
opa run --server --set=decision_logs.console=true --bundle app/ data.json
```

You can then make requests to the server, using the -d flag to specify input data. To specify a policy/decision, modify the URL to include the package and rule name. I.e. `http://localhost:8181/v1/data/app/{package}/{decision}`.

```bash
# check if alice has "properties__read" access against the RBAC policy
curl http://localhost:8181/v1/data/app/rbac/allow -d '{"input": {"user":"alice", "actions":["properties__read"]}}'

# check if alice has "properties__read" access on entity "a"
curl http://localhost:8181/v1/data/app/rbac_with_entity_check/allow -d '{"input": {"user":"alice", "actions":["properties__read"], "entity":"a"}}'
```
