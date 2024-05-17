package salesianos.triana.dam.ChokeCheck.user.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import salesianos.triana.dam.ChokeCheck.apply.model.Apply;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.error.exception.NotAuthorException;
import salesianos.triana.dam.ChokeCheck.error.exception.NotFoundException;
import salesianos.triana.dam.ChokeCheck.like.model.Like;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.post.repository.PostRepository;
import salesianos.triana.dam.ChokeCheck.post.service.PostService;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;
import salesianos.triana.dam.ChokeCheck.tournament.repository.TournamentRepository;
import salesianos.triana.dam.ChokeCheck.tournament.service.TournamentService;
import salesianos.triana.dam.ChokeCheck.user.dto.*;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;
import salesianos.triana.dam.ChokeCheck.user.model.User;
import salesianos.triana.dam.ChokeCheck.user.model.UserRole;
import salesianos.triana.dam.ChokeCheck.user.repository.UserRepository;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository repo;
    private final PasswordEncoder passwordEncoder;
    private final PostService postService;
    private final PostRepository postRepository;
    private final TournamentService tournamentService;
    private final TournamentRepository tournamentRepository;

    public Optional<User> findById(UUID userId) {
        return repo.findById(userId);
    }
    public boolean existEmail(String s ) {
        return repo.getAllEmails().stream().toList().contains(s);
    }

    public boolean existUsername(String s ) {
        return repo.getAllUsernames().stream().toList().contains(s);
    }

    public Optional<User> findByUsername(String name){
        return repo.findFirstByUsername(name);
    }

    public Optional<User> saveUser(UserRegister u){
        User user = UserRegister.fromUserRegister(u);
        user.setPassword(passwordEncoder.encode(u.getPassword()));
        user.setRoles(Set.of(UserRole.USER));
        return Optional.of(
                repo.save(user)
        );
    }
    public Optional<User> saveAnyUser(CreateUserRequest u){
        User user = CreateUserRequest.fromCreateUserRequest(u);
        user.setPassword(passwordEncoder.encode(u.getPassword()));
        if (u.getRol() == 0)
            user.setRoles(Set.of(UserRole.ADMIN));
        else
            user.setRoles(Set.of(UserRole.ADMIN));

        return Optional.of(
                repo.save(user)
        );
    }

    public UserDetailResponse findDetailByUsername(String username, User user){
        Optional<User> selected= repo.findFirstByUsername(username);
        if(selected.isEmpty()) throw new NotFoundException("User");
        return UserDetailResponse.of(selected.get(), postService.getAllPostByCreatorUsername(username, user));
    }
    public MyPage<UserListResponse> findAll(Pageable pageable){
        return MyPage.of(repo.findAll(pageable).map(UserListResponse::of));
    }

    public UserDetailResponse editUser(User ancient, EditUser newUser){
        ancient.setAge(newUser.getAge());
        ancient.setSex(newUser.getSex());
        ancient.setHeight(newUser.getHeight());
        ancient.setWeight(newUser.getWeight());
        ancient.setPassword(passwordEncoder.encode(newUser.getPassword()));
        ancient.setName(newUser.getName());
        ancient.setSurname(newUser.getSurname());
        ancient.setBelt_color(getBeltColor(newUser.getBeltColor()));
        ancient.setEmail(newUser.getEmail());
        repo.save(ancient);
        return UserDetailResponse.of(ancient, postService.getAllPostByCreatorUsername(ancient.getUsername(), ancient));
    }

    public UserDetailResponse editUser(EditAllUser newUser, UUID id){
        Optional<User> selected = repo.findById(id);
        if(selected.isEmpty()) throw  new NotFoundException("User");
        User ancient = selected.get();
        ancient.setAge(newUser.getAge());
        ancient.setSex(newUser.getSex());
        ancient.setHeight(newUser.getHeight());
        ancient.setWeight(newUser.getWeight());
        ancient.setPassword(passwordEncoder.encode(newUser.getPassword()));
        ancient.setName(newUser.getName());
        ancient.setSurname(newUser.getSurname());
        ancient.setBelt_color(getBeltColor(newUser.getBeltColor()));
        ancient.setEmail(newUser.getEmail());
        if (newUser.getRol() == 0)
            ancient.setRoles(Set.of(UserRole.ADMIN));
        else
            ancient.setRoles(Set.of(UserRole.ADMIN));
        repo.save(ancient);
        return UserDetailResponse.of(ancient, postService.getAllPostByCreatorUsername(ancient.getUsername(), ancient));
    }
    public static BeltColor getBeltColor(String beltColor){
        if (beltColor.equals("RED")) return BeltColor.RED;
        if (beltColor.equals("BLUE")) return BeltColor.BLUE;
        if (beltColor.equals("BLACK")) return BeltColor.BLACK;
        if (beltColor.equals("RED_WHITE")) return BeltColor.RED_WHITE;
        if (beltColor.equals("RED_BLACK")) return BeltColor.RED_BLACK;
        if (beltColor.equals("WHITE")) return BeltColor.WHITE;
        if (beltColor.equals("PURPLE")) return BeltColor.PURPLE;
        if (beltColor.equals("BROWN")) return BeltColor.BROWN;
        return BeltColor.WHITE;
    }

    public void deleteUser(UUID id){
        Optional<User> selected= repo.findById(id);
        if(selected.isEmpty()) throw new NotFoundException("User");
        List<Post> toDelete = postRepository.findAllByAuthorUsername(selected.get().getUsername());
        toDelete.forEach((post)-> {
            try {
                postService.deletePost(post.getId(), selected.get());
            } catch (NotAuthorException e) {
                throw new RuntimeException(e);
            }
        });
        List<Tournament> allTourn = tournamentRepository.getAllIds(tournamentRepository.findAll().stream().map(Tournament::getId).toList());
        allTourn.forEach(tournament -> {
            if(tournament.getApplies().stream().map(Apply::getAuthor).map(User::getId).toList().contains(selected.get().getId())){
                tournamentService.deleteApply(tournament.getId(), selected.get());
            }
        });
        List<Post> toDeleteLikeRate = postRepository.findAll();
        toDeleteLikeRate.forEach(post -> {
            if(post.getLikes().stream().map(l -> l.getAuthor().getId()).toList().contains(selected.get().getId())){
                postService.deleteLike(post.getId(), selected.get());
            }
        });
        repo.delete(selected.get());

    }

    public List<UserBestPublisher> getThreeBestPublisher(){
        User [] result = new User[3];
        List<Post> allPostMonth = postRepository.getAllByCreatedAtMonth(LocalDate.now().getMonthValue());
        List<User> allUser = repo.findAll();
        Map<User, Integer> userAppliesMap = new HashMap<>();
        List<User> sortedUsers = new ArrayList<>();
        for (User user : allUser) {
            userAppliesMap.put(user, (int) allPostMonth.stream()
                    .filter(a -> a.getAuthor().getId().equals(user.getId()))
                    .count());
        }
        sortedUsers = userAppliesMap.entrySet().stream()
                .sorted(Map.Entry.<User, Integer>comparingByValue().reversed())
                .limit(3)
                .map(Map.Entry::getKey)
                .toList();

        return sortedUsers.stream().map(u -> UserBestPublisher.of(u, userAppliesMap.get(u))).toList();
    }

    public UserMostAppliers getFiveBestAppliers() {
        List<User> allUser = repo.findAll();
        List<Apply> allApplyMonth = tournamentRepository.getAllApplyByCreatedAtMonth(LocalDate.now().getMonthValue());
        List<User> sortedUsers = new ArrayList<>();
        Map<User, Integer> userAppliesMap = new HashMap<>();
        List<UserBestPublisher> finish = new ArrayList<>();
        for (User user : allUser) {
            int actualNumber = (int) allApplyMonth.stream()
                    .filter(a -> a.getAuthor().getId().equals(user.getId()))
                    .count();

            userAppliesMap.put(user, actualNumber);
        }

        sortedUsers = userAppliesMap.entrySet().stream()
                .sorted(Map.Entry.<User, Integer>comparingByValue().reversed())
                .limit(5)
                .map(Map.Entry::getKey)
                .toList();


        for (User user : sortedUsers) {
            UserBestPublisher userResult = UserBestPublisher.of(user, userAppliesMap.get(user));
            finish.add(userResult);
        }

        return UserMostAppliers.of(finish, allApplyMonth.size());
    }
}
