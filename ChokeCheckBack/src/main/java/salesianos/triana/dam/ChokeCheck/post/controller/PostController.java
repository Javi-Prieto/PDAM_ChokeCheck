package salesianos.triana.dam.ChokeCheck.post.controller;

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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.error.exception.NotAuthorException;
import salesianos.triana.dam.ChokeCheck.error.exception.NotBeltLevelException;
import salesianos.triana.dam.ChokeCheck.post.dto.CreatePostDto;
import salesianos.triana.dam.ChokeCheck.post.dto.PostDto;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.post.service.PostService;
import salesianos.triana.dam.ChokeCheck.rate.dto.RateDto;
import salesianos.triana.dam.ChokeCheck.rate.model.Rate;
import salesianos.triana.dam.ChokeCheck.user.model.User;

import java.util.UUID;

@RestController
@RequestMapping("/post")
@RequiredArgsConstructor
public class PostController {
    private final PostService service;


    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtains all the post paged", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Post.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
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
                                                    ],
                                                    "size": 10,
                                                    "totalElements": 3,
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
                            }))
    })
    @Operation(summary = "Find all the Posts", description = "Returns a paged list of all the post in the api")
    @GetMapping()
    public MyPage<PostDto> getAllPost(@PageableDefault(page = 0, size = 10) Pageable pageable){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User author = (User) auth.getPrincipal();
        return service.getAllPost(pageable, author);
    }
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The Rate Created Correctly", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Rate.class)),
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
                            array = @ArraySchema(schema = @Schema(implementation = PostDto.class))))
    })
    @Operation(summary = "Create new Rate", description = "Create new Rate")
    @PostMapping("/{id}/rate")
    public ResponseEntity<?> ratePost(@PathVariable UUID id, @RequestBody @Valid RateDto newRate) throws NotBeltLevelException {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User author = (User) auth.getPrincipal();
        return ResponseEntity.status(201).body(service.addRate(author, newRate, id));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The Post Created Correctly", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Post.class)),
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
                            array = @ArraySchema(schema = @Schema(implementation = PostDto.class))))
    })
    @Operation(summary = "Create new Post", description = "Create new Post")
    @PostMapping()
    public ResponseEntity<?> createPost(@RequestBody @Valid CreatePostDto newPost){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User autor = (User) auth.getPrincipal();
        return ResponseEntity.status(201).body(service.createPost(newPost, autor));
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
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePost(@PathVariable UUID id) throws NotAuthorException {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) auth.getPrincipal();
        service.deletePost(id, user);
        return ResponseEntity.noContent().build();
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Like a post", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Post.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "04a1f811-c826-48aa-a601-7f72bd614303",
                                                    "type": "TRAINING",
                                                    "authorName": "javi.prieto",
                                                    "authorBelt": "RED",
                                                    "likes": 1,
                                                    "isLikedByLoggedUser": false,
                                                    "isRatedByLoggedUser": false,
                                                    "avgRate": 9.0,
                                                    "title": "My First Ever Training",
                                                    "content": "3x3min Jump Ropes,4x3min Pads,5x3min Sparring"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401",
                    description = "Not logged user",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = PostDto.class))))
    })
    @Operation(summary = "Create new Like", description = "Like a post")
    @PostMapping("/like/{id}")
    public ResponseEntity<?> addLike(@PathVariable UUID id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) auth.getPrincipal();
        return ResponseEntity.status(201).body(service.addLike(id, user));
    }
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "The Like and it's rates deleted correctly",
                    content = @Content
            ),
            @ApiResponse(responseCode = "404",
                    description = "Not Found the Like or Post to delete",
                    content = @Content)
    })
    @Operation(summary = "Delete Like", description = "Returns 204 no content if everything is good ")
    @DeleteMapping("/like/{id}")
    public ResponseEntity<?> deleteLike(@PathVariable UUID id){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) auth.getPrincipal();
        service.deleteLike(id, user);
        return ResponseEntity.noContent().build();
    }
}
