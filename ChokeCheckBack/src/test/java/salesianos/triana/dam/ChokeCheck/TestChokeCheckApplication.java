package salesianos.triana.dam.ChokeCheck;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.TestConfiguration;

@TestConfiguration(proxyBeanMethods = false)
public class TestChokeCheckApplication {

	public static void main(String[] args) {
		SpringApplication.from(ChokeCheckApplication::main).with(TestChokeCheckApplication.class).run(args);
	}

}
