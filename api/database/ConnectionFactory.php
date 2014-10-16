<?php # ConnectionFactory.php - provides our database connections for the API

class ConnectionFactory {
    private static $factory;
    private $db;

    public static function getFactory() {
        if (!self::$factory) {
            self::$factory = new ConnectionFactory();
		}
        return self::$factory;
    }

    public function getConnection() {
        if (!isset($this->db)) {
			try {
				$filename = '../private/dbc.cfg';

				if (file_exists($filename) && is_readable ($filename)) {
					$data = file_get_contents($filename);
					$data = explode("\n", $data);

					for ($i = 0; $i < count($data); $i++) {
						$data[$i] = trim($data[$i]);
					}

					$this->db = new PDO(
						'mysql:host=' . $data[0] . ';dbname=' . $data[1] . ';charset=utf8', 
						$data[2],  
						$data[3],
						array(
							PDO::ATTR_EMULATE_PREPARES => false, 
							PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
						)
					);
				}
			} catch (PDOException $e) {
				echo "Error connecting to the database.<br />" . PHP_EOL;
			}
        }
        return $this->db;
    }
}