## Prolog

#### Demo

```bash
cd prolog
./demo.sh
```

#### Unit tests

```bash
cd prolog
./test.sh
```

#### HTTP Server

```bash
docker build -t agh-expert-systems-prolog .
docker run --rm -p 5000:5000 agh-expert-systems-prolog
```

API:

* `POST http://localhost:5000/api/can-remove-tiles`
* `POST http://localhost:5000/api/suggest-moves`
