package salesianos.triana.dam.ChokeCheck.post.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import salesianos.triana.dam.ChokeCheck.assets.MyPage;
import salesianos.triana.dam.ChokeCheck.error.exception.NotAuthorException;
import salesianos.triana.dam.ChokeCheck.error.exception.NotBeltLevelException;
import salesianos.triana.dam.ChokeCheck.error.exception.NotFoundException;
import salesianos.triana.dam.ChokeCheck.image.model.Image;
import salesianos.triana.dam.ChokeCheck.image.service.ImageServiceImpl;
import salesianos.triana.dam.ChokeCheck.like.model.Like;
import salesianos.triana.dam.ChokeCheck.like.model.LikePk;
import salesianos.triana.dam.ChokeCheck.post.dto.CreatePostDto;
import salesianos.triana.dam.ChokeCheck.post.dto.PostDto;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.post.repository.PostRepository;
import salesianos.triana.dam.ChokeCheck.rate.dto.RateDto;
import salesianos.triana.dam.ChokeCheck.rate.model.Rate;
import salesianos.triana.dam.ChokeCheck.rate.model.RatePk;
import salesianos.triana.dam.ChokeCheck.user.model.BeltColor;
import salesianos.triana.dam.ChokeCheck.user.model.User;
import salesianos.triana.dam.ChokeCheck.user.model.UserRole;

import java.util.*;


@Service
@RequiredArgsConstructor
public class PostService {
    private final PostRepository repository;
    private final ImageServiceImpl imageService;

    public MyPage<PostDto> getAllPost(Pageable pageable, User user){
        Page<Post> all = repository.findAll(pageable);
        List<Post> result = repository.findAllPaged(all.getContent().stream().map(Post::getId).toList());

        Page<PostDto> toReturn = all.map(PostDto::ofWithNoRating);
        List<PostDto> toConvert = new ArrayList<>();
        result.forEach((post )-> {
            if(post.getFileName().isEmpty()){
                toConvert.add(PostDto.of(post, user));
            }else{
                Image image = imageService.load(post.getFileName());
                toConvert.add(PostDto.ofWithImage(post, user, image));
            }

        } );
        return MyPage.of(toReturn, toConvert);
    }

    public PostDto createPost(CreatePostDto newPost, User author){
        Post toSave = CreatePostDto.from(newPost);
        toSave.setAuthor(author);
        return PostDto.of(repository.save(toSave), author);
    }

    public PostDto createPost(CreatePostDto newPost, User author, MultipartFile image){
        Post toSave = CreatePostDto.from(newPost);
        Image imageComp = imageService.store(image);
        toSave.setFileName(imageComp.getFileName());
        toSave.setAuthor(author);
        return PostDto.ofWithImage(repository.save(toSave), author, imageComp);
    }
    public PostDto addLike(UUID id, User logged){
        Optional<Post> selected = repository.findFirstById(id);
        if(selected.isEmpty()) throw new NotFoundException("Post");
        Post selectedPost = selected.get();
        Like toAdd = Like.builder().author(logged).post(selectedPost).build();
        toAdd.setId(new LikePk(logged, selectedPost));
        selectedPost.addLike(toAdd);
        repository.saveAndFlush(selectedPost);
        return PostDto.of(selectedPost, logged);
    }

    public void deleteLike(UUID id, User logged){
        Optional<Post> selected = repository.findFirstById(id);
        if(selected.isEmpty()) throw new NotFoundException("Post");
        Like toCompare = new Like(logged, selected.get());
        toCompare.setId(new LikePk(logged, selected.get()));
        Optional<Like> selectedLike = repository.findLikeByLike(toCompare);
        if(selectedLike.isEmpty()) throw new NotFoundException("Like");
        Post selectedPost = selected.get();
        Like selectedL = selectedLike.get();
        selectedPost.deleteLike(selectedL);
        repository.save(selectedPost);
        repository.deleteLike(selectedL);
    }

    public void deletePost(UUID id, User user) throws NotAuthorException {
        Optional<Post> post = repository.findById(id);
        if(post.isEmpty()) throw new NotFoundException("Post");
        if (!post.get().getAuthor().getId().equals(user.getId()) && !user.getRoles().contains(UserRole.ADMIN)) throw new NotAuthorException();
        repository.delete(post.get());
    }

    public List<PostDto> getAllPostByCreatorUsername(String username, User user){
        List<UUID> ids = repository.findAllByAuthorUsername(username).stream().map(Post::getId).toList();
        return repository.findAllPaged(ids).stream().map(p -> PostDto.of(p, user)).toList();
    }

    public PostDto addRate(User user, RateDto rateDto, UUID id) throws NotBeltLevelException {
        Optional<Post> selected = repository.findFirstById(id);
        if(selected.isEmpty()) throw new NotFoundException("Post");
        if(getNumberFromBelt(user.getBelt_color())< getNumberFromBelt(selected.get().getAuthor().getBelt_color())) throw new NotBeltLevelException();
        Post selectedPost = selected.get();
        Rate toAdd = new Rate(user, selectedPost, rateDto.rate());
        toAdd.setId(new RatePk(user, selectedPost));
        if(repository.findRatebyRate(toAdd).isEmpty()){
            selectedPost.addRate(toAdd);
            repository.save(selectedPost);
        }else{
            selectedPost.deleteRate(repository.findRatebyRate(toAdd).get());
            selectedPost.addRate(toAdd);
            repository.save(selectedPost);
        }
        return PostDto.of(selectedPost, user);

    }
    public static int getNumberFromBelt(BeltColor belt) {
        return switch (belt) {
            case WHITE -> 0;
            case BLUE -> 1;
            case PURPLE -> 2;
            case BROWN -> 3;
            case BLACK -> 4;
            case RED_BLACK -> 5;
            case RED_WHITE -> 6;
            case RED -> 7;
        };
    }

}
