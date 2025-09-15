package com;

import com.intuit.karate.junit5.Karate;

public class PetRunner {

    @Karate.Test
    Karate testPetstore(){
        return Karate.run("petstore/create_pet").relativeTo(getClass());
    }
}
