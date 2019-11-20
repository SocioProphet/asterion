IMAGE=alephdata/asterion

sanctions:
	mkdir -p data
	curl -o data/us_ofac.json https://storage.googleapis.com/occrp-data-exports/us_ofac/us_ofac.json
	curl -o data/eu_eeas_sanctions.json https://storage.googleapis.com/occrp-data-exports/eu_eeas_sanctions/eu_eeas_sanctions.json
	curl -o data/ch_seco_sanctions.json https://storage.googleapis.com/occrp-data-exports/ch_seco_sanctions/ch_seco_sanctions.json

build:
	docker build -t ${IMAGE} .

run: build
	docker run -p 7474:7474 -p 7687:7687 ${IMAGE}