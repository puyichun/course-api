json.data do
  json.array! @course do |course|
    json.name course.name
    json.teacher course.teacher
    json.description course.description
    json.chapter course.chapters do |chapter|
      json.name chapter.name
      json.unit chapter.units do |unit|
        json.name unit.name
      end
    end
  end

end