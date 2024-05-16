package salesianos.triana.dam.ChokeCheck.post.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import salesianos.triana.dam.ChokeCheck.apply.model.Apply;
import salesianos.triana.dam.ChokeCheck.like.model.Like;
import salesianos.triana.dam.ChokeCheck.post.model.Post;
import salesianos.triana.dam.ChokeCheck.rate.model.Rate;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface PostRepository extends JpaRepository<Post, UUID> {

    @Query("""
            Select p from Post p
            left join fetch p.rating
            left join fetch p.likes
            where p.id in (:ids)
            order by p.id
            """)
    List<Post> findAllPaged(List<UUID> ids);

    List<Post> findAllByAuthorUsername(String username);

    @Query("""
            SELECT p FROM Post p 
            WHERE MONTH(p.createdAt) = :month
            """)
    List<Post> getAllByCreatedAtMonth(int month);

    @Query("""
            select p from Post p
            left join fetch p.rating
            left join fetch p.likes
            where p.id = (:id)
            """)
    Optional<Post> findFirstById(UUID id);

    @Query("""
            select l from Like l
            where l = :like
            """)
    Optional<Like> findLikeByLike(Like like);
    @Query("""
            delete from Like l
            where l = :like
            """)
    @Transactional
    @Modifying
    void deleteLike(Like like);

    @Query("""
            select r from Rate r
            where r = :rate
            """)
    Optional<Rate> findRatebyRate(Rate rate);
}
