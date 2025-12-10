package edu.sm.app.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class FakeUser {
    private String id;
    private String name;

    // getter / setter
}