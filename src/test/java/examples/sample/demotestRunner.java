package examples.login;

import com.intuit.karate.junit5.Karate;

class demotestRunner {
    
    @Karate.Test
    Karate testLogin() {
        return Karate.run("demotest").relativeTo(getClass());
    }    

}
