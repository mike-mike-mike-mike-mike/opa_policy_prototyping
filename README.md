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
```bash
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
