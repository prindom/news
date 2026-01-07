<?php

namespace Models;

class Database {
    private string $databaseFile;
    private SQLite3 $connection;

    public function __construct(string $databaseFile) {
        $this->databaseFile = $databaseFile;
    }

    public function connect(): void {
        $this->connection = new SQLite3($this->databaseFile);

        if (!$this->connection) {
            die("Connection failed: " . $this->connection->lastErrorMsg());
        }
    }

    public function disconnect(): void {
        $this->connection->close();
    }

    public function executeQuery(string $query): SQLite3Result|bool {
        $statement = $this->connection->prepare($query);
        $result = $statement->execute();

        if (!$result) {
            die("Query failed: " . $this->connection->lastErrorMsg());
        }

        return $result;
    }

    public function installTables(): void {
        // Execute SQL queries to create necessary tables
        $this->executeQuery("CREATE TABLE IF NOT EXISTS news (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )");

        // Add more table creation queries as needed

        echo "Tables installed successfully.";
    }
}
