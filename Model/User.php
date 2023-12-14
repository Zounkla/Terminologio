<?php

class User {

    private String $username;
    private String $password;

    public function __construct(String $username, String $password) {
        $this->username = $username;
        $this->password = $password;
    }

    public function getUsername():String {
        return $this->username;
    }

    public function getPassword():String { 
        return $this->password;
    }

    public function setUsername(String $username):void {
        $this->username = $username;
    }

    public function setPassword(String $password):void {
        $this->password = $password;
    }
}