# frozen_string_literal: true

# Copyright (c) 2023 [Ribose Inc](https://www.ribose.com).
# All rights reserved.
# This file is a part of the Tebako project.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

# Unpack mn2pdf.jar

module TebakoRuntime
  MN2PDF_J_PATH = TebakoRuntime.extract_memfs(File.join(TebakoRuntime.full_gem_path("mn2pdf"), "bin",
                                                        "mn2pdf.jar"))
end

if Mn2pdf.const_defined?("MN2PDF_JAR_PATH")
  module Mn2pdf
    remove_const("MN2PDF_JAR_PATH")
    MN2PDF_JAR_PATH = TebakoRuntime::MN2PDF_J_PATH
  end
end

if Jvm.const_defined?("MN2PDF_JAR_PATH")
  module Jvm
    remove_const("MN2PDF_JAR_PATH")
    MN2PDF_JAR_PATH = TebakoRuntime::MN2PDF_J_PATH
  end
end

module Mn2pdf
  singleton_class.send(:alias_method, :convert_orig, :convert)
  singleton_class.send(:remove_method, :convert)

  def self.convert(url_path, output_path, xsl_stylesheet, options)
    convert_orig(TebakoRuntime.extract_memfs(url_path), output_path, TebakoRuntime.extract_memfs(xsl_stylesheet),
                 options)
  end
end
