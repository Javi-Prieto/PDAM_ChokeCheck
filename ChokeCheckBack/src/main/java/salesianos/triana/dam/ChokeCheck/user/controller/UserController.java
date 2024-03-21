package salesianos.triana.dam.ChokeCheck.user.controller;

import com.fasterxml.jackson.annotation.JsonView;
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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.security.jwt.access.JwtProvider;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.user.dto.*;
import salesianos.triana.dam.ChokeCheck.user.model.User;
import salesianos.triana.dam.ChokeCheck.user.service.UserService;



@RestController
@RequiredArgsConstructor
public class UserController {

    private final JwtProvider jwtProvider;
    private final AuthenticationManager authManager;
    private final UserService userService;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "El usuario se ha registrado correctamente", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68",
                                                    "username": "javi.prieto",
                                                    "userBeltColor": "RED",
                                                    "rol": "ADMIN",
                                                    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxY2U5YzFjNy03YTAyLTRjN2YtYmY2OS02ZDAzMDZjYmVkNjgiLCJpYXQiOjE3MDg2ODU0ODEsImV4cCI6MTcwODc3MTg4MX0.fwfNi-hvl502DxUXHC0gBbX26mb9MkO_N_4KEzELl5vO3Vsq9JENvZBTHx47aIxm6iHaWSAWBPjFIKldlFGx4g"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "Los datos introducidos no son válidos",
                    content = @Content)
    })
    //@CrossOrigin
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody @Valid UserLogin userLogin){

        try{
            Authentication authentication = authManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            userLogin.getUsername(),
                            userLogin.getPassword()
                    )
            );

            SecurityContextHolder.getContext().setAuthentication(authentication);

            String token = jwtProvider.generateToken(authentication);

            User user = (User) authentication.getPrincipal();

            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(JwtUserResponse.of(user, token));
        }catch (BadCredentialsException e){
            if(e.getMessage().equals("Bad credentials")){
                return ResponseEntity.badRequest().body("Not correct password");
            }
            throw new BadCredentialsException(e.getMessage());
        }


    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtains the page of all the user", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "content": [
                                                        {
                                                            "name": "javi",
                                                            "surname": "prieto",
                                                            "username": "javi.prieto",
                                                            "belt": "red",
                                                            "age": 19,
                                                            "weight": 76,
                                                            "height": 178,
                                                            "sex": 0,
                                                            "email": "javi@gmail.com"
                                                        },
                                                        {
                                                            "name": "paco",
                                                            "surname": "perez",
                                                            "username": "paquito_er_chulo",
                                                            "belt": "blue",
                                                            "age": 19,
                                                            "weight": 76,
                                                            "height": 178,
                                                            "sex": 0,
                                                            "email": "apquito@gmail.com"
                                                        }
                                                    ],
                                                    "size": 10,
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
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
                            examples = {@ExampleObject(
                                    """
                                        {
                                            "error": "You can not do this"
                                        }
                                    """
                            )
                            })),
            @ApiResponse(responseCode = "403",
                    description = "Access denied",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
                            examples = {@ExampleObject(
                                    """
                                        {
                                            "error": "You can not do this"
                                        }
                                    """
                            )
                            }))
    })
    @Operation(summary = "Find all the users", description = "Returns all the users paged")
    @GetMapping("/user/")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public MyPage<UserListResponse> getProfileByUsername(@PageableDefault() Pageable pageable){
        return userService.findAll(pageable);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtains the user with the requested username", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "name": "paco",
                                                    "surname": "perez",
                                                    "username": "paquito_er_chulo",
                                                    "belt": "blue",
                                                    "age": 19,
                                                    "weight": 19,
                                                    "sex": 0,
                                                    "posts": [
                                                        {
                                                            "id": "399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6",
                                                            "type": "TRAINING",
                                                            "authorName": "paquito_er_chulo",
                                                            "authorBelt": "BLUE",
                                                            "likes": 95,
                                                            "avgRate": 1.0,
                                                            "title": "My First Ever Training",
                                                            "content": "3x3min|Jump Ropes,4x3min|Pads,5x3min|Sparring"
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401",
                    description = "Not logged user",
                    content = @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
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
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
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
    @GetMapping("/user/{username}")
    @PreAuthorize("isAuthenticated()")
    public UserDetailResponse getProfileByUsername(@PathVariable String username){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User author = (User) auth.getPrincipal();
        return userService.findDetailByUsername(username, author);
    }


    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "El usuario se ha creado correctamente", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68",
                                                    "username": "javi.prieto",
                                                    "userBeltColor": "RED",
                                                    "rol": "ADMIN",
                                                    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxY2U5YzFjNy03YTAyLTRjN2YtYmY2OS02ZDAzMDZjYmVkNjgiLCJpYXQiOjE3MDg2ODU0ODEsImV4cCI6MTcwODc3MTg4MX0.fwfNi-hvl502DxUXHC0gBbX26mb9MkO_N_4KEzELl5vO3Vsq9JENvZBTHx47aIxm6iHaWSAWBPjFIKldlFGx4g"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "Los datos introducidos no son válidos",
                    content = @Content)
    })
    @PostMapping("/register")
    public ResponseEntity<JwtUserResponse> save (@Valid @RequestBody UserRegister u){
        userService.saveUser(u).orElseThrow();

        Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(
                        u.getUsername(),
                        u.getPassword()
                ));
        SecurityContextHolder.getContext().setAuthentication(authentication);

        String token = jwtProvider.generateToken(authentication);
        User toRet = (User) authentication.getPrincipal();
        return ResponseEntity.status(HttpStatus.CREATED).body(JwtUserResponse.of(toRet, token));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "El usuario se ha creado correctamente", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = User.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "id": "1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68",
                                                    "username": "javi.prieto",
                                                    "userBeltColor": "RED",
                                                    "rol": "ADMIN",
                                                    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxY2U5YzFjNy03YTAyLTRjN2YtYmY2OS02ZDAzMDZjYmVkNjgiLCJpYXQiOjE3MDg2ODU0ODEsImV4cCI6MTcwODc3MTg4MX0.fwfNi-hvl502DxUXHC0gBbX26mb9MkO_N_4KEzELl5vO3Vsq9JENvZBTHx47aIxm6iHaWSAWBPjFIKldlFGx4g"
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "Los datos introducidos no son válidos",
                    content = @Content)
    })
    @PutMapping("/edit/my_profile")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> editMyProfile(@Valid @RequestBody EditUser u){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User author = (User) auth.getPrincipal();
        return ResponseEntity.status(HttpStatus.CREATED).body(userService.editUser(author, u));
    }


}
