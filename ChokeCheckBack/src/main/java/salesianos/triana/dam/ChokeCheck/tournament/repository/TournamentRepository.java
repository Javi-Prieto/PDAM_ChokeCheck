package salesianos.triana.dam.ChokeCheck.tournament.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import salesianos.triana.dam.ChokeCheck.apply.model.Apply;
import salesianos.triana.dam.ChokeCheck.apply.model.ApplyPk;
import salesianos.triana.dam.ChokeCheck.tournament.model.Tournament;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface TournamentRepository extends JpaRepository<Tournament, UUID> {

    @Query("""
            select t from Tournament t
            where :weight between t.minWeight and t.maxWeight
            and :sex = t.sex
            """)
    Page<Tournament> getTournamentByWeightInAndSex(int weight, byte sex, Pageable pageable);
    @Query("""
            select t from Tournament t
            left join fetch t.applies as a
            where t.id in (:ids)
            and t.participants > size(a)
            order by t.prize
            """)
    List<Tournament> getAllIds(List<UUID> ids);

    @Query("""
            SELECT t FROM Tournament t 
            WHERE MONTH(t.createdAt) = :month
            """)
    List<Tournament> getAllByCreatedAtMonth(int month);

    @Query("""
            select t from Tournament t
            left join fetch t.applies as a
            where t.id = :id
            """)
    Optional<Tournament> findByIdWithApplies(UUID id);

    @Query("""
            delete from Apply a
            where a = :apply
            """)
    @Transactional
    @Modifying
    void deleteApply(Apply apply);

    @Query("""
            select a from Apply a
            where a.tournament.id = :id
            """)
    List<Apply> findAllApplies(UUID id);
}
