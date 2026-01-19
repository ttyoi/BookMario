package com.bookmario.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewResponseDTO {
	private boolean success;
    private String message;
    private Long rno;
    
    public ReviewResponseDTO(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

}
