<?php

class APIController {
    private $multiplier;

    public function __construct($mult) {
        $this->multiplier = $mult;
    }

    public function multiply($number) {
        return $number * $this->multiplier;
    }
}