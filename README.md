# dsp-stack
dsp stack

The dev way of setting up a stack is to build it, clone [dsp-api](https://github.com/dasch-swiss/dsp-api), checkout the [release](https://github.com/dasch-swiss/dsp-api/releases) if not latest commit, `make` will guide you.

In order to run the same versions (docker images) as deployed on prod, test or where-ever, we set a docker stack with fixed versions and associated ontologies, config files, init scripts.

Once cloned, a `make` will guide you through the process, which is usually:

```bash
# bootstrap the triple store:
make db-init
# check what's running, so far only the triple store
make ps
# bring up the rest of the stack
make up
# check the logs
make logs
```

once up, you can access:
- older salsah/tangoh on http://localhost:3335/
- newer dsp-app on http://localhost:4200/
- fuseki triple store web gui on http://localhost:3030/
- dsp-api on http://localhost:3333/

# set branches for given set of versions

create branches out the `main` branch for given set of versions

# anatomy of the code

- docker-compose.yml # stolen from [here](https://raw.githubusercontent.com/dasch-swiss/dsp-api/main/docker-compose.yml)
- knora-ontologies/  # stolen from [here](https://github.com/dasch-swiss/dsp-api/tree/main/knora-ontologies)
- Makefile
- README.md
- scripts/           # selected files stolen from [here](https://github.com/dasch-swiss/dsp-api/tree/main/webapi/scripts)  
- sipi/              # stolen from [here](https://github.com/dasch-swiss/dsp-api/tree/main/sipi)
- test_data/         # selected files stolen from [here](https://github.com/dasch-swiss/dsp-api/tree/main/test_data) 
