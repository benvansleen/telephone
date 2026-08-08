package app

type DB struct{}

func (d *DB) Query() string {
	return fetch()
}

func (d *DB) Close() {
	shutdown()
}
