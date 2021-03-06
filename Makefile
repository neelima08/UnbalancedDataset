.PHONY: all clean test
PYTHON=python
NOSETESTS=nosetests

all:
	$(PYTHON) setup.py build_ext --inplace

clean:
	find . -name "*.so" -o -name "*.pyc" -o -name "*.md5" -o -name "*.pyd" -o -name "*~" | xargs rm -f
	find . -name "*.pyx" -exec ./tools/rm_pyx_c_file.sh {} \;
	rm -rf coverage
	rm -rf dist
	rm -rf build

test:
	$(NOSETESTS) -s -v unbalanced_dataset

# doctest:
# 	$(PYTHON) -c "import unbalanced_dataset, sys, io; sys.exit(unbalanced_dataset.doctest_verbose())"

coverage:
	$(NOSETESTS) unbalanced_dataset -s -v --with-coverage --cover-package=unbalanced_dataset

html:
	conda install -y sphinx sphinx_rtd_theme numpydoc
	export SPHINXOPTS=-W; make -C doc html
