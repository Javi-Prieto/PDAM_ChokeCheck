package salesianos.triana.dam.ChokeCheck.gym.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;
import salesianos.triana.dam.ChokeCheck.gym.service.GymService;

@RestController
@RequiredArgsConstructor
public class GymController {
    private final GymService service;
}
