module UsersHelper

  def profile_image_tag(user, size: 100)
    if user.profile_image.attached?
      image_tag user.profile_image
              .variant(resize_to_fill: [size, size]),
              width: size,
              height: size,
              class: "rounded object-fit-cover d-block"
    else
      image_tag "no_image.jpeg",
              width: size,
              height: size,
              class: "rounded object-fit-cover d-block"
    end
  end
end
