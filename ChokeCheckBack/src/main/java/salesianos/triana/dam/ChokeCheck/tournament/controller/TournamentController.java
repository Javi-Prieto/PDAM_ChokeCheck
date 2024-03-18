package salesianos.triana.dam.ChokeCheck.tournament.controller;

import com.fasterxml.jackson.annotation.JsonView;
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
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.error.exception.NotBeltLevelException;
import salesianos.triana.dam.ChokeCheck.post.dto.PostDto;
import salesianos.triana.dam.ChokeCheck.rate.model.Rate;
import salesianos.triana.dam.ChokeCheck.tournament.dto.TournamentDto;
import salesianos.triana.dam.ChokeCheck.tournament.jsonView.TournamentViews;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.tournament.service.TournamentService;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.util.UUID;

@RestController
@RequestMapping("/tournament")
@RequiredArgsConstructor
public class TournamentController {
    private final TournamentService service;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtains all the Tournament paged", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Tournament.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                                    "title": "Sparring Time",
                                                                    "date": "2024-12-01 17:30:15",
                                                                    "participants": 8,
                                                                    "applied": 0,
                                                                    "higherBelt": "RED_WHITE",
                                                                    "prize": 0.0,
                                                                    "author": "Sutemi MMA"
                                                        }
                                                    ],
                                                    "size": 10,
                                                    "totalElements": 1,
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
                            array = @ArraySchema(schema = @Schema(implementation = Tournament.class)),
                            examples = {@ExampleObject(
                                    """
                                        {
                                            "error": "You can not do this"
                                        }
                                    """
                            )
                            }))
    })
    @Operation(summary = "Find all the Tournaments", description = "Returns a paged list of all the tournament in the api")
    @GetMapping()
    @JsonView(TournamentViews.TournamentList.class)
    public MyPage<TournamentDto> getAll(@PageableDefault(size = 10, page = 0) Pageable pageable){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User logged = (User) auth.getPrincipal();
        return service.getAll(logged, pageable);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtains all the Tournament paged", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Tournament.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                                    "title": "Sparring Time",
                                                                    "date": "2024-12-01 17:30:15",
                                                                    "participants": 8,
                                                                    "applied": 0,
                                                                    "higherBelt": "RED_WHITE",
                                                                    "prize": 0.0,
                                                                    "author": "Sutemi MMA"
                                                        }
                                                    ],
                                                    "size": 10,
                                                    "totalElements": 1,
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
                            array = @ArraySchema(schema = @Schema(implementation = Tournament.class)),
                            examples = {@ExampleObject(
                                    """
                                        {
                                            "error": "You can not do this"
                                        }
                                    """
                            )
                            })),
            @ApiResponse(responseCode = "404",
                    description = "Not Found",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Tournament.class)),
                            examples = {@ExampleObject(
                                    """
                                        {
                                            "error": "Not Found the Tournament or the list you are looking for"
                                        }
                                    """
                            )
                            }))
    })
    @Operation(summary = "Find Tournament by id", description = "Returns the Tournament the client asked for")
    @GetMapping("/{id}")
    @JsonView(TournamentViews.TournamentDetail.class)
    public TournamentDto getById(@PathVariable UUID id){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User logged = (User) auth.getPrincipal();
        return service.getById(id, logged);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The Rate Created Correctly", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Tournament.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "title": "Sparring Time",
                                                    "date": "2024-08-01 17:30:15",
                                                    "cost": 0.0,
                                                    "participants": 8,
                                                    "applied": 1,
                                                    "higherBelt": "RED",
                                                    "prize": 0.0,
                                                    "author": "Gracie",
                                                    "minWeight": 72,
                                                    "isAppliedByLoggedUser": false,
                                                    "maxWeight": 77,
                                                    "content": "Nice tournament",
                                                    "lat": 37.37821574699546,
                                                    "lon": -5.999276495573956,
                                                    "city": "Seville"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401",
                    description = "Not correct belt level",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "Not Tournament found",
                    content = @Content),
            @ApiResponse(responseCode = "401",
                    description = "Not logged user",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Tournament.class))))
    })
    @PostMapping("/apply/{id}")
    @JsonView(TournamentViews.TournamentDetail.class)
    public ResponseEntity<?> createApply(@PathVariable UUID id) throws NotBeltLevelException {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User logged = (User) auth.getPrincipal();
        return ResponseEntity.status(201).body(service.addApply(id, logged));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "The post and it's rates deleted correctly",
                    content = @Content
            ),
            @ApiResponse(responseCode = "404",
                    description = "Not Found the Post to delete",
                    content = @Content)
    })
    @Operation(summary = "Delete Post", description = "Returns 204 no content if everything is good ")
    @DeleteMapping("/apply/{id}")
    public ResponseEntity<?> deleteApplyFromTournament(@PathVariable UUID id){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User logged = (User) auth.getPrincipal();
        service.deleteApply(id, logged);
        return ResponseEntity.noContent().build();
    }

}
