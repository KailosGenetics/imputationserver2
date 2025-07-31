include { BEAGLE_IMPUTATION } from '../modules/local/imputation/beagle_imputation'

workflow IMPUTATION {
    take:
    phased_ch
    
    main:
    chromosomes = Channel.of(1..22, 'X.nonPAR', 'X.PAR1', 'X.PAR2', 'MT')
    
    beagle_reference_ch = chromosomes
        .map {
            it ->
                def beagle_file = file(PatternUtil.parse(params.refpanel.refBeagle, [chr: it]))
                if(!beagle_file.exists()){
                    return null;
                }
                return tuple(it.toString(), beagle_file)
        }

    beagle_map_ch = chromosomes
        .map {
            it ->
                def beagle_map_file = file(PatternUtil.parse(params.refpanel.mapBeagle, [chr: it]))
                if(!beagle_map_file.exists()){
                    return null;
                }
                return tuple(it.toString(), beagle_map_file)
        }

    // Combine all channels properly
    beagle_ref_map_ch = beagle_reference_ch.combine(beagle_map_ch, by: 0)
    beagle_bcf_metafiles_ch = phased_ch.combine(beagle_ref_map_ch, by: 0)

    BEAGLE_IMPUTATION(beagle_bcf_metafiles_ch)

    // Transform output to match expected imputation format
    imputed_chunks = BEAGLE_IMPUTATION.out.beagle_imputed_ch
        .map { chr, start, end, phasing_status, vcf_file ->
            // Return in the format expected by the pipeline: 
            // tuple val(chr), val(start), val(end), file(dose_vcf), file(info), file(empirical)
            tuple(chr, start, end, vcf_file, vcf_file, vcf_file)
        }

    emit:
    imputed_chunks = imputed_chunks
}
