module ApplicationHelper
  def flash_styles_for(type)
    {
      notice:  ["bg-blue-100",  "text-blue-800",  "border-blue-400",  "information-circle"],
      alert:   ["bg-red-100",   "text-red-800",   "border-red-400",   "exclamation-triangle"],
      success: ["bg-green-100", "text-green-800", "border-green-400", "check-circle"]
    }.fetch(type.to_sym, ["bg-gray-100", "text-gray-800", "border-gray-400", "question-mark-circle"])
  end
end
