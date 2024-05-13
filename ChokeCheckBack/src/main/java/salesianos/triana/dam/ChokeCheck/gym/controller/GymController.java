package salesianos.triana.dam.ChokeCheck.gym.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymRequest;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymResponse;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;
import salesianos.triana.dam.ChokeCheck.gym.service.GymService;

import java.util.UUID;


@RestController
@RequestMapping("/gym")
@RequiredArgsConstructor
public class GymController {
    private final GymService service;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtains all the Gym paged", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GymResponse.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                            "id": "83b8640e-b7d7-4f4b-8224-8f21f38b776a",
                                                            "name": "Gracie",
                                                            "avgBelt": "RED_WHITE",
                                                            "latitude": -5.999276495573956,
                                                            "altitude": 37.37821574699546,
                                                            "numberTournaments": 2
                                                        },
                                                    ],
                                                    "size": 2,
                                                    "totalElements": 2,
                                                    "pageNumber": 0,
                                                    "first": true,
                                                    "last": true
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401",
                    description = "Not logged user",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GymResponse.class)),
                            examples = {@ExampleObject(
                                    """
                                        {
                                            "error": "You can not do this"
                                        }
                                    """
                            )
                            })),
            @ApiResponse(responseCode = "403",
                    description = "Acces Denied",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GymResponse.class)),
                            examples = {@ExampleObject(
                                    """
                                    {
                                        "status": "FORBIDDEN",
                                        "message": "Access Denied",
                                        "path": "/gym",
                                        "dateTime": "19/03/2024 14:22:07"
                                    }
                                    """
                            )
                            }))
    })
    @Operation(summary = "Find all the Gyms", description = "Returns a paged list of all the Gym in the api")
    @GetMapping()
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public MyPage<GymResponse> getAll(@PageableDefault(page = 0, size = 10) Pageable pageable){
        return service.getAll(pageable);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The Gym Created Correctly", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Gym.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "04a1f811-c826-48aa-a601-7f72bd614303",
                                                    "type": "TRAINING",
                                                    "authorName": "javi.prieto",
                                                    "authorBelt": "RED",
                                                    "likes": 1,
                                                    "avgRate": 9.0,
                                                    "title": "My First Ever Training",
                                                    "content": "3x3min Jump Ropes,4x3min Pads,5x3min Sparring"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "The body is not correct",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "Not logged user",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GymResponse.class))))
    })
    @Operation(summary = "Create new Gym", description = "Create new Gym")
    @PostMapping()
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public GymResponse createGym(@RequestBody @Valid GymRequest gymRequest){
        return service.createGym(gymRequest);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The Gym was Edited Correctly", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Gym.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "04a1f811-c826-48aa-a601-7f72bd614303",
                                                    "type": "TRAINING",
                                                    "authorName": "javi.prieto",
                                                    "authorBelt": "RED",
                                                    "likes": 1,
                                                    "avgRate": 9.0,
                                                    "title": "My First Ever Training",
                                                    "content": "3x3min Jump Ropes,4x3min Pads,5x3min Sparring"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "The body is not correct",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "Not logged user",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GymResponse.class))))
    })
    @Operation(summary = "Edit Gym", description = "Edit Gym")
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public GymResponse editGym(@RequestBody @Valid GymRequest gymRequest, @PathVariable UUID id){
        return service.editGym(gymRequest, id);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "The Gym and it's applies deleted correctly",
                    content = @Content
            ),
            @ApiResponse(responseCode = "404",
                    description = "Not Found the Gym to delete",
                    content = @Content)
    })
    @Operation(summary = "Delete Gym", description = "Returns 204 no content if everything is good ")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> deleteGym(@PathVariable UUID id) {
        service.deleteGym(id);
        return ResponseEntity.noContent().build();
    }
}
