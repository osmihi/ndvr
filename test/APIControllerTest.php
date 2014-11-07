<?php

require_once('api/APIController.php');

class APIControllerTest extends PHPUnit_Framework_TestCase {

    public function testWorksForPositive() {
        // Arrange
        $ac = new APIController(5);

        // Act
        $product = $ac->multiply(10);

        // Assert
        $this->assertEquals(50, $product);
    }

    public function testWorksForNegative() {
        // Arrange
        $ac = new APIController(-5);

        // Act
        $product = $ac->multiply(10);

        // Assert
        $this->assertEquals(-50, $product);
    }

    public function testWorksForZero() {
        // Arrange
        $ac = new APIController(0);

        // Act
        $product = $ac->multiply(10);

        // Assert
        $this->assertEquals(0, $product);
    }
}
