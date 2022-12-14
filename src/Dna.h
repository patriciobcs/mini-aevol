//
// Created by arrouan on 01/10/18.
//

#pragma once

#include <vector>
#include <zlib.h>
#include <random>

#include<bits/stdc++.h>

#include "lib/aevol_constants.h"

class Dna {

public:
    Dna() = default;

    Dna(const Dna &clone) = default;

    Dna(int length, std::shared_ptr<std::mt19937_64> rng, int level_, int n_threads);

    ~Dna() = default;

    int length() const;

    void save(gzFile backup_file);

    void load(gzFile backup_file);

    void set(int pos, char c);

    /// Remove the DNA inbetween pos_1 and pos_2
    void remove(int pos_1, int pos_2);

    /// Insert a sequence of a given length at a given position into the DNA of the Organism
    void insert(int pos, std::vector<char> seq);

    /// Insert a sequence of a given length at a given position into the DNA of the Organism
    void insert(int pos, Dna *seq);

    void do_switch(int pos);

    void do_duplication(int pos_1, int pos_2, int pos_3);

    int promoter_at(int pos);

    int terminator_at(int pos);

    bool shine_dal_start(int pos);

    bool protein_stop(int pos);

    int codon_at(int pos);

    std::vector<char> seq_;

    int level_;
};
