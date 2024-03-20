package salesianos.triana.dam.ChokeCheck.assets;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.Builder;
import org.springframework.data.domain.Page;
import salesianos.triana.dam.ChokeCheck.tournament.jsonView.TournamentViews;

import java.util.List;

@Builder
@JsonView({TournamentViews.TournamentList.class, TournamentViews.TournamentTable.class})
public record MyPage<T>(

        List<T> content,

        Integer size,

        Long totalElements,

        Integer pageNumber,

        boolean first,
        boolean last

)  {
    public static <T> MyPage<T> of(Page<T> page){
        return MyPage.<T>builder()
                .content(page.getContent())
                .first(page.isFirst())
                .last(page.isLast())
                .pageNumber(page.getPageable().getPageNumber())
                .size(page.getPageable().getPageSize())
                .totalElements(page.getTotalElements())
                .build();
    }
    public static <T> MyPage<T> of(Page<T> page, List<T> content){
        return MyPage.<T>builder()
                .content(content)
                .first(page.isFirst())
                .last(page.isLast())
                .pageNumber(page.getPageable().getPageNumber())
                .size(content.size())
                .totalElements(page.getTotalElements())
                .build();
    }
}
