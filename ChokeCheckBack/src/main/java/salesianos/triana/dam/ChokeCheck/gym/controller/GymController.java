package salesianos.triana.dam.ChokeCheck.gym.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.gym.dto.GymResponse;
import salesianos.triana.dam.ChokeCheck.gym.model.Gym;
import salesianos.triana.dam.ChokeCheck.gym.service.GymService;
import salesianos.triana.dam.ChokeCheck.post.dto.PostDto;
import salesianos.triana.dam.ChokeCheck.post.model.Post;



@RestController
@RequestMapping("/gym")
@RequiredArgsConstructor
public class GymController {
    private final GymService service;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtains all the post paged", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Post.class)),
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
                            array = @ArraySchema(schema = @Schema(implementation = PostDto.class)),
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
                            array = @ArraySchema(schema = @Schema(implementation = PostDto.class)),
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
    @Operation(summary = "Find all the Posts", description = "Returns a paged list of all the post in the api")
    @GetMapping()
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public MyPage<GymResponse> getAll(@PageableDefault(page = 0, size = 10) Pageable pageable){
        return service.getAll(pageable);
    }

}
